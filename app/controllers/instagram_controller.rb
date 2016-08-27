class InstagramController < ApplicationController

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => SocialMedia.redirect_url(1), :scope => 'basic public_content likes follower_list comments relationships')
  end

  def callback
    if params[:error]
      redirect_to current_user, notice: params[:error_description]
    else
      response = Instagram.get_access_token(params[:code], redirect_uri: SocialMedia.redirect_url(1))
      if feed = current_user.instagram
        feed.update_attribute(:token, response.access_token)
      else
        current_user.social_medium.create(
          feed_type: 1,
          full_name: response.user.full_name,
          username: response.user.username,
          picture: response.user.profile_picture,
          token: response.access_token
          )
      end
      redirect_to current_user
    end
  end

end
