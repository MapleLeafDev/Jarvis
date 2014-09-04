class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :family
  helper_method :gravatar_for
  helper_method :family_url
  helper_method :is_parent
  helper_method :children
  helper_method :parents

  before_filter :user_agent_detect

  def user_agent_detect
    if request.user_agent =~ /iPad/
      request.variant = :tablet
    elsif request.user_agent =~ /iPhone/
      request.variant = :phone
    end
  end

  def resolve_layout
    case action_name
    when "my_family"
      if request.variant && request.variant.include?(:phone)
        "my_family_m"
      else
        "my_family"
      end
    else
      if request.variant && request.variant.include?(:phone)
        "application_m"
      else
        "application"
      end
    end
  end

  private

  def current_user
    if session[:user_id]
      if User.find_by_id(session[:user_id]) != nil
        @current_user = User.find_by_id(session[:user_id])
      end
    end
  end

  def is_parent
    redirect_to user_path(current_user), alert: t('controllers.not_authorized') unless current_user.parent?
  end

  def authorize
    redirect_to login_url, alert: t('controllers.need_to_sign_in') if !current_user
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

  def children
    users = Array.new
    if current_user.family
      memberships = FamilyMember.where(family_id: current_user.family.id)
      memberships.each do |membership|
        member = User.find_by_id(membership.user_id)
        if member.user_type < 10
          users << member
        end
      end
    end
    return users
  end

  def parents
    users = Array.new
    if current_user.family
      memberships = FamilyMember.where(family_id: current_user.family.id)
      memberships.each do |membership|
        member = User.find_by_id(membership.user_id)
        if member.user_type >= 10
          users << member
        end
      end
    else
      users << current_user
    end
    return users
  end

  def gravatar_for(user, size = nil)
    id = Digest::MD5::hexdigest (user.email || user.name).strip.downcase
    url = 'http://www.gravatar.com/avatar/' + id + '?d=retro'
    url += "&s=#{size}" if size
    return url
  end

end