class GoogleController < ApplicationController

  def connect
    redirect_to "/auth/google_oauth2"
  end

  def callback
    params = request.env['omniauth.auth']
    if feed = current_user.google
      feed.update_attributes(token: params[:credentials][:token], secret: params[:credentials][:secret])
    else
      current_user.social_medium.create(
        feed_type: 5,
        full_name: params[:info][:name],
        user_id: params[:info][:uid],
        username: params[:info][:nickname],
        picture: params[:info][:image],
        token: params[:credentials][:token],
        secret: params[:credentials][:secret]
        )
    end
    redirect_to current_user
  end
end
