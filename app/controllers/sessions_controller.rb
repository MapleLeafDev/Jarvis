class SessionsController < ApplicationController
  respond_to :html, :js
  layout "layouts/login"

  def new
  end

  def create
    if params[:pin]
      if @user = User.find_by_id_and_pin(params[:id], params[:pin])
        session[:user_id] = @user.id
      else
        @error = t('pin_doesnt_match')
      end
    else
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
      else
        @error = t('email_password_invalid')
      end
    end
  end

  def destroy
    url = current_user.family.portal_url
    session[:user_id] = nil
    redirect_to url
  end
end
