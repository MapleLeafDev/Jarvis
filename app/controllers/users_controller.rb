class UsersController < ApplicationController
  respond_to :html, :js
  before_filter :authorize, except: [:new, :create]

  layout :resolve_layout

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html.phone { render template: "users/show_m" }
      format.html
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if current_user
      @user.family_id = current_user.family_id
    end

    if @user.save
      session[:user_id] = @user.id unless current_user
      flash[:notice] = t('controllers.user_created', user: @user.name)
    end
    respond_with @user
  end

  def update
    @user = User.find(params[:id])

    flash[:notice] = t('controllers.user_updated', user: @user.name) if @user.update_attributes(user_params)
    respond_with @user
  end

  def multi
    @user = User.find(params[:id])
    @task = @user.tasks.new()
  end

  def allowance
    @user = User.find(params[:id])

    credits = @user.credits || 0
    allowance = @user.allowance || 0

    @user.update_attributes({credits: credits + allowance, last_allowance: Date.today})

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
