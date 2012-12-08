class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :family
  helper_method :gravatar_for

  def current_user
    if ENV['RAILS_ENV'] == 'development'
      @current_user = User.find(1)
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  def user_check
    if current_user == nil
      redirect_to root_url
    end
  end

  def family
    if current_user.parent_id == nil || current_user.parent_id == ""
      users = User.where(parent_id: current_user.id)
      users << current_user
    else
      users = User.where(parent_id: current_user.parent_id)
      users << User.find_by_id(current_user.parent_id)
    end
    return users
  end

  def gravatar_for(email)
    id = Digest::MD5::hexdigest email.strip.downcase
    url = 'http://www.gravatar.com/avatar/' + id + '?d=retro'
    return url
  end
end