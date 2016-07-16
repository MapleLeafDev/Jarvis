class UsersController < ApplicationController
  respond_to :html, :js
  before_filter :get_user, except: [:new, :create]
  before_filter :authorize, except: [:new, :create]
  before_filter :authorize_family, except: [:new, :create]

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

  def multi
    @task = @user.tasks.new()
  end

  def social_medium
  end

  def allowance
    @user.apply_allowance

    redirect_to @user.family
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def get_user
    @user = User.find(params[:id])
  end

  def authorize_family
    redirect_to current_user unless (@user == current_user || @user.family_id == current_user.family_id)
  end
end
