class UsersController < ApplicationController
  respond_to :html, :js
  before_filter :is_admin, only: [:index, :toggle]
  before_filter :get_user, except: [:index, :new, :create, :signup]
  before_filter :authorize, except: [:new, :create, :signup]
  before_filter :authorize_family, except: [:index, :new, :create, :toggle, :destroy, :signup]

  layout "login", :only => [:signup]

  def index
    @page = (params[:page] || 1).to_i
    @users = User.page @page
  end

  def show
  end

  def new
    @user = User.new
  end

  def signup
    @user = User.new
    @family = Family.new
    if current_user
      redirect_to (current_user.family_id ? family_path(current_user.family) : user_path(current_user))
    end
  end

  def edit
  end

  def create
    if family_params
      unless @family = Family.find_by_url(family_params[:url])
        @family = Family.new(family_params)
        @family.url = @family.name + "-" + Random.new.rand(1000000000..10000000000).to_s
        @family.save
      end
    end

    @user = User.new(user_params)
    @user.family_id = current_user.family_id if current_user
    @user.family_id = @family.id if @family
    @user.enabled = true
    if @user.save
      session[:user_id] = @user.id unless current_user
      flash[:notice] = t('user_created')
    end
    respond_with @user
  end

  def update
    flash[:notice] = t('user_updated') if @user.update_attributes(user_params)
    respond_with @user
  end

  def toggle
    if @user
      @user.update_attribute(:enabled, !@user.enabled)
    end
  end

  def social_medium
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def family_params
    params.require(:family).permit!
  end

  def get_user
    @user = params[:id] ? User.find(params[:id]) : current_user
  end

  def authorize_family
    redirect_to current_user unless (@user == current_user || @user.family_id == current_user.family_id)
  end
end
