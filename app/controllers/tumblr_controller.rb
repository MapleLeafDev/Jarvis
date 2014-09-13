class TumblrController < ApplicationController
  before_filter :create_oauth_object

  def connect
    redirect_to "#{@oauth.url_for_oauth_code(permissions: 'email,read_stream')}"
  end

  def callback
    info = request.env["omniauth.auth"]
    Rails.logger.info "......  #{ap info}"
    credentials = request.env["omniauth.auth"]['credentials']
    if feed = current_user.tumblr
      feed.update_attribute(:token, "#{credentials['secret']}:#{credentials['token']}")
    else
      current_user.social_medium.create(
        feed_type: 3,
        full_name: info['info']['name'],
        username: info['uid'],
        picture: info['info']['avatar'],
        token: "#{params[:oauth_token]}:#{params[:oauth_verifier]}"
        )
    end

    redirect_to current_user
  end

  private

  def create_oauth_object
    @oauth = Koala::Facebook::OAuth.new("1474290372850967", "d1a1f67e937b28a0c1b4fb0d1ad537d3", SocialMedia.facebook_redirect_uri)
  end

end
