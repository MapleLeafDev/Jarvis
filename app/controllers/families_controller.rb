class FamiliesController < ApplicationController
  respond_to :html, :js
  before_filter :get_family, except: [:my_family, :new, :create]
  before_filter :authorize, except: [:my_family]
  before_filter :authorize_family, except: [:my_family, :new, :create]
  before_filter :is_parent, except: [:my_family, :show]

  layout "my_family", :only => [:my_family]

  def show
    @members = @family.users.order(:dob)
    @activities = @family.activities.order('posted_at desc')
  end

  def my_family
    if @user = User.find_by_token(params[:token])
      session[:user_id] = @user.id
      redirect_to root_url
    elsif @family = Family.find_by_url(params[:url])
      @users = @family.users
    else
      redirect_to root_url
    end
  end

  def new
    @family = Family.new
  end

  def edit
  end

  def create
    if @family = Family.find_by_url(params[:family][:url])
      current_user.update_attribute(:family_id, @family.id)
    else
      @family = Family.new(family_params)
      @family.url = @family.name + "-" + Random.new.rand(1000000000..10000000000).to_s
      if @family.save
        current_user.update_attribute(:family_id, @family.id)
      end
    end
  end

  def update
    flash[:notice] = t('family_updated') if @family.update_attributes(family_params)
    respond_with @family
  end

  def destroy
    @family.children.each{|user| user.destroy}
    @family.destroy
    redirect_to current_user
  end

  private

  def family_params
    params.require(:family).permit!
  end

  def get_family
    @family = current_user.family
  end

  def authorize_family
    redirect_to current_user.family unless @family.id == current_user.family_id
  end
end
