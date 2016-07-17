class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :family, :gravatar_for, :family_url, :is_parent, :children, :parents, :is_admin

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def is_admin
    redirect_to user_path(current_user), alert: t('not_authorized') unless current_user.email == ENV['ADMIN']
  end

  def is_parent
    redirect_to user_path(current_user), alert: t('not_authorized') unless current_user.parent?
  end

  def authorize
    redirect_to root_path, alert: t('need_to_sign_in') if !current_user
  end

  def family
    if family = current_user.family
      family.users
    else
      [current_user]
    end
  end

  def children
    if family = current_user.family
      family.children
    else
      []
    end
  end

  def parents
    if family = current_user.family
      family.parents
    else
      [current_user]
    end
  end

  def gravatar_for(user, size = nil)
    id = Digest::MD5::hexdigest (user.email || user.name).strip.downcase
    url = 'http://www.gravatar.com/avatar/' + id + '?d=retro'
    url += "&s=#{size}" if size
    return url
  end

end
