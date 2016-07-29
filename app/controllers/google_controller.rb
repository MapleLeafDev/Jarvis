class GoogleController < ApplicationController

  def connect
    redirect_to "/auth/google_oauth2"
  end

  def callback
    params = request.env['omniauth.auth']
    puts params
    if feed = current_user.google
      feed.update_attributes(token: params[:credentials][:refresh_token])
    else
      current_user.social_medium.create(
        feed_type: 5,
        uid: params[:uid],
        full_name: params[:info][:name],
        username: params[:info][:email],
        picture: params[:info][:image],
        token: params[:credentials][:refresh_token]
        )
    end
    redirect_to "/profile"
  end
end
