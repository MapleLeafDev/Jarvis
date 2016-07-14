class SessionsController < ApplicationController
  respond_to :html, :js
  layout "layouts/login"

  def new
  end

  def create
    if params[:pin]
      user = User.find_by_id_and_pin(params[:id], params[:pin].to_i)
      if user
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        redirect_to :back, notice: t('pin_doesnt_match')
      end
    else
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        redirect_to root_url, notice: t('email_password_invalid')
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
