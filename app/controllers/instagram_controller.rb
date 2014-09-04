class InstagramController < ApplicationController

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => "http://localhost:3000/instagram/callback")
  end

  def callback
    response = Instagram.get_access_token(params[:code], redirect_uri: "http://localhost:3000/instagram/callback")
    if feed = current_user.media_feeds.where(feed_type: 1).first
      feed.update_attribute(:token, response.access_token)
    else
      current_user.media_feeds.create(
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
