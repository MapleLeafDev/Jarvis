class UsersController < ApplicationController
  respond_to :html, :js
  before_filter :is_admin, only: [:index, :toggle]
  before_filter :get_user, except: [:index, :new, :create]
  before_filter :authorize, except: [:new, :create]
  before_filter :authorize_family, except: [:index, :new, :create, :toggle, :destroy]

  def index
    @page = (params[:page] || 1).to_i
    @users = User.page @page
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.family_id = current_user.family_id if current_user
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

  def get_user
    @user = params[:id] ? User.find(params[:id]) : current_user
  end

  def authorize_family
    redirect_to current_user unless (@user == current_user || @user.family_id == current_user.family_id)
  end
end
