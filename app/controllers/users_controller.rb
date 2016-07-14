class UsersController < ApplicationController
  respond_to :html, :js
  before_filter :authorize, except: [:new, :create]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.family_id = current_user.family_id if current_user

    if @user.save
      session[:user_id] = @user.id unless current_user
      flash[:notice] = t('user_created')
    end
    respond_with @user
  end

  def update
    @user = User.find(params[:id])
    flash[:notice] = t('user_updated') if @user.update_attributes(user_params)
    respond_with @user
  end

  def multi
    @user = User.find(params[:id])
    @task = @user.tasks.new()
  end

  def social_medium
    @user = User.find(params[:id])
  end

  def allowance
    @user = User.find(params[:id])
    @user.apply_allowance

    redirect_to @user.family
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
