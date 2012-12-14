class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if params[:pin]
      if User.find_by_id_and_pin(params[:id], params[:pin].to_i)
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Logged in!"
      else
        redirect_to :back, notice: "Email or password is invalid"
      end
    else
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Logged in!"
      else
        redirect_to root_url, notice: "Email or password is invalid"
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end