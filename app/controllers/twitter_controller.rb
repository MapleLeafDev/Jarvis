class TwitterController < ApplicationController

  def connect
    redirect_to "/auth/twitter"
  end

  def callback
    params = request.env['omniauth.auth']
    if feed = current_user.twitter
      feed.update_attributes(token: params[:credentials][:token], secret: params[:credentials][:secret])
    else
      current_user.social_medium.create(
        feed_type: 4,
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
