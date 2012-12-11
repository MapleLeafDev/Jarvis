class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :family
  helper_method :gravatar_for
  helper_method :family_url

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

  def family
    users = Array.new
    if current_user.family
      memberships = FamilyMember.where(family_id: current_user.family.id)
      memberships.each do |membership|
        users << User.find_by_id(membership.user_id)
      end
    else
      users << current_user
    end
    return users
  end

  def gravatar_for(email)
    id = Digest::MD5::hexdigest email.strip.downcase
    url = 'http://www.gravatar.com/avatar/' + id + '?d=retro'
    return url
  end
end