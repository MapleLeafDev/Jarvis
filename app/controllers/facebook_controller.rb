class FacebookController < ApplicationController
  before_filter :create_oauth_object

  def connect
    redirect_to "#{@oauth.url_for_oauth_code(permissions: 'email,read_stream')}"
  end

  def callback
    access_token = @oauth.get_access_token(params[:code])
    if feed = current_user.facebook
      feed.update_attribute(:token, access_token)
    else
      graph = Koala::Facebook::API.new(access_token)
      response = graph.get_object("me")
      picture = graph.get_picture(response['id'])
      current_user.social_medium.create(
        feed_type: 2,
        full_name: response['name'],
        username: response['id'],
        picture: picture,
        token: access_token
        )
    end

    redirect_to current_user
  end

  private

  def create_oauth_object
    @oauth = Koala::Facebook::OAuth.new("1474290372850967", "d1a1f67e937b28a0c1b4fb0d1ad537d3", SocialMedia.facebook_redirect_uri)
  end

end
