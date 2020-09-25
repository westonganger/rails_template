class Admin::UsersController < Admin::BaseController
  before_action :get_user, except: [:index, :new, :create]

  respond_to :html, :json, :js

  def index
    @users = User.order("people.last_name ASC").includes(:person, :company, :organization, :roles).page(params[:page]).per(20)
    
    if params[:scope] && params[:scope] != 'All'
      case params[:scope]
      when 'invitation_sent'
        @users = @users.invitation_sent
      when 'Disabled'
        @users = @users.only_deleted
      when 'Enabled'
        @users = @users.where(deleted_at: nil)
      end
    end

    ### Filter/Search Records
    if params[:search_text].present?
      case params[:filter]
      when 'All'
        @users = @users.search(params[:search_text]).uniq
      when 'First Name'
        @users = @users.search_first_name(params[:search_text])
      when 'Last Name'
        @users = @users.search_last_name(params[:search_text])
      when 'Full Name'
        @users = @users.search_full_name(params[:search_text])
      when 'Email'
        @users = @users.search_email(params[:search_text])
      when 'Role'
        @users = @users.search_roles(params[:search_text])
      when 'Organization/HQ'
        @users = @users.search_organization(params[:search_text])
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    redirect_to action: :edit
  end

  def new
    @user = User.new
    @user.person_id = params[:person_id] if params[:person_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    if params[:user][:skip_invitation] != "1"
      params[:user] = params[:user].except(:skip_invitation)
    end

    @user = User.new(User.strong_params(params))

    if @user.save
      @user.invite!(current_user)

      flash[:notice] = 'User successfully invited.'
      flash.keep(:notice)
    end

    respond_with @user, location: admin_users_path
  end

  def edit
  end

  def update
    if @user.update(User.strong_params(params))
      flash[:notice] = 'User successfully updated.'
      flash.keep(:notice)
    end

    respond_with @user, location: admin_users_path
  end


  def destroy
    @user.destroy

    flash[:notice] = 'User successfully disabled.'
    flash.keep(:notice)

    respond_to do |format|
      format.html { redirect_to action: :index }
      format.json { head :no_content }
    end
  end

  def enable
    @user.deleted_at = nil

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User successfully enabled.'
        flash.keep(:notice)

        format.html { redirect_to action: :index }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def resend_invitation
    @user.invite!(current_user)

    respond_to do |format|
      format.html { redirect_to action: :index, notice: 'Invite re-sent.' }
      format.json { render json: @user, status: :created, location: @user }
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

end
