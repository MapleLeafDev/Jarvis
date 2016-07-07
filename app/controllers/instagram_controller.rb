class InstagramController < ApplicationController

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => SocialMedia.instagram_redirect_uri, :scope => 'basic public_content follower_list')
  end

  def callback
    if params[:error]
      redirect_to current_user, notice: params[:error_description]
    else
      response = Instagram.get_access_token(params[:code], redirect_uri: SocialMedia.instagram_redirect_uri)
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
