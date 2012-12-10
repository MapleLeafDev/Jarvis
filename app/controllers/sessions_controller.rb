class SessionsController < ApplicationController

  def create
    
    session[:user_id] = user.id
    redirect_to users_path, :notice => "Signed in"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out"
  end
end