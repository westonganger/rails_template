class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  impersonates :user # for pretender gem

  helper_method :stored_location_for

  before_action :ensure_request_format
  before_action :authenticate_user!
  before_action :check_session_validity
  #before_action :check_session_time
  before_action :set_paper_trail_whodunnit
  after_action :ensure_permissions_checked

  layout :determine_layout

  def require_admin
    if !current_user.has_role?(:admin)
      raise Error::Unauthorized
    end
  end

  private

  def ensure_request_format
    request.format ||= 'html'
  end

  def is_modal?
    request.xhr?
  end

  def determine_layout
    if request.xhr?
      'modal'
    else
      'application'
    end
  end

  ### Devise Config
  def after_sign_in_path_for(resource_or_scope)
    is_signing_in = devise_controller? && params[:controller] == 'devise/users/sessions' && ['new','create'].include?(params[:action])

    path = root_path

    if is_signing_in
      ### If the user is signing in then return to the stored location or default defined path
      stored_location_for(resource_or_scope) || path
    else
      session.delete(stored_location_key_for(:user))

      path
    end
  end

  def authenticate_user!(*args)
    storable_location = request.get? && is_navigational_format? && !devise_controller? && !request.xhr?

    if storable_location && [root_path].exclude?(URI(request.fullpath).path)
      ### Store the url they were trying to access in case the user is signed out
      store_location_for(:user, request.fullpath)
    end

    if user_signed_in? || devise_controller?
      super
    else
      redirect_to devise.new_user_session_path
    end
  end
  ### END Devise Config
  
  ### If admin disables a user while they are logged in, log them out upon the next request
  def check_session_validity
    if @current_user && @current_user.deleted_at
      sign_out @current_user
      redirect_to root_path, alert: 'Your account has been disabled by an administrator. You have been signed out.'
    end
  end

  ### Require the user to re-enter their credentials after 8 hours of login time
  def check_session_time
    if !Rails.env.test? && @current_user && (@current_user.current_sign_in_at + 8.hours) < Time.now
      sign_out @current_user
      unless request[:path] == root_path
        redirect_to devise_ldap.new_user_session_path
      end
    end
  end

  ### Authorization Methods
  def allow(condition=true)
    restrict(condition)
  end

  def restrict(condition)
    if condition
      @permissions_checked = true
    else
      raise Error::Unauthorized
    end
  end
  
  def restrict_to_admin
    if current_user.has_role?(:admin)
      @permissions_checked = true
    else
      raise Error::Unauthorized
    end
  end

  def check_permission(record, action=nil)
    if record.nil?
      raise ArgumentError.new("first argument of `check_permission` cannot be nil")
    end

    if action
      action = action.to_sym
    else
      case params[:action]
      when 'index','show'
        action = :read
      when 'new','create'
        action = :create
      when 'edit','update'
        action = :update
      when 'destroy'
        action = :destroy
      else
        raise ArgumentError.new("second argument of `check_permission` cannot be empty for non-CRUD action")
      end
    end

    if can?(action, record)
      @permissions_checked = true
    else
      raise Error::Unauthorized
    end
  end

  def ensure_permissions_checked
    unless devise_controller? || @permissions_checked
      raise 'Permissions were not checked on this action'
    end
  end

  def dont_allow_user_self_registration
    if devise_controller?
      if params[:controller].end_with?('/registrations')
        raise Error::Unauthorized
      elsif params[:controller].end_with?('/invitations') && ['edit','update'].exclude?(params[:action])
        raise Error::Unauthorized
      end
    end
  end

  rescue_from Error::Unauthorized do |exception|
    if current_user
      ExceptionNotifier.notify_exception(exception, {
        env: request.env, 
        data: {
          msg: "403 Error"
        }
      })
    end

    if request.format.html?
      if request.xhr?
        render file: Rails.root.join('public/403.html'), layout: 'modal'
      else
        redirect_to root_path, alert: 'Unauthorized!'
      end
    elsif request.format.js?
      flash[:alert] = 'Unauthorized!'
      flash.keep(:alert)
      render js: "window.location = '#{root_path}'"
    else
      head 403
    end
  end
  ### END Authorization Methods

  rescue_from Error::InvalidBehaviour do |exception|
    ExceptionNotifier.notify_exception(exception, {
      env: request.env, 
      data: {
        msg: "Invalid Application Behaviour Detected"
      }
    })

    flash_message = 'Sorry. An error occured. The administrator has been notified.'

    if request.format == 'js'
      flash[:alert] = flash_message
      flash.keep(:alert)
      render js: "window.location = window.location;"
    else
      redirect_to root_path, alert: flash_message
    end
  end

end
