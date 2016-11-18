class UsersController < ApplicationController
  respond_to :html, :js
  before_filter :is_admin, only: [:index, :toggle]
  before_filter :get_user, except: [:index, :new, :create, :signup, :register]
  before_filter :authorize, except: [:new, :create, :signup, :register]
  before_filter :authorize_family, except: [:index, :new, :create, :toggle, :destroy, :signup, :register]

  layout "login", :only => [:signup]

  def index
    @family = current_user.family
    @page = (params[:page] || 1).to_i
    @users = User.page @page
  end

  def show
    @activities = @user.activities.order('posted_at desc')
    @tasks = Task.sort_by_member(@user.family_id)[@user.id]
    puts @tasks
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

  def register
    unless @family = Family.find_by_url(family_params[:url])
      @family = Family.new(family_params)
      @family.url = @family.name + "-" + Family.random_id
      @family.valid?
    end

    @user = User.new(user_params)
    @user.family_id = current_user.family_id if current_user
    @user.family_id = @family.id if @family
    @user.enabled = true
    @user.valid?

    unless @user.errors.any? || @family.errors.any?
      @user.save
      @family.save
      session[:user_id] = @user.id
      flash[:notice] = t('user_created')
    else
      @family.url = nil
      render :signup, layout: 'login'
    end
  end

  def edit
  end

  def create
    if params[:family]
      unless @family = Family.find_by_url(family_params[:url])
        @family = Family.new(family_params)
        @family.url = @family.name + "-" + Family.random_id
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
    else
      respond_with @user
    end
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
