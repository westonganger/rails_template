class BaseController < ActionController::Base

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
