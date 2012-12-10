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

  def family
    users = Array.new
    memberships = FamilyMember.where(family_id: current_user.family.id)
    memberships.each do |membership|
      users << User.find_by_id(membership.user_id)
    end
    return users
  end

  def user_check
    if current_user == nil
      redirect_to root_url
    end
  end

  def gravatar_for(email)
    id = Digest::MD5::hexdigest email.strip.downcase
    url = 'http://www.gravatar.com/avatar/' + id + '?d=retro'
    return url
  end
end