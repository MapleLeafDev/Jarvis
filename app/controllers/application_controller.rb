class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private

  def current_user
    if ENV['RAILS_ENV'] == 'development'
      @current_user = User.find(1)
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
end
