class TwitterController < ApplicationController

  def connect
    redirect_to "/auth/twitter"
  end

  def callback
    @user = current_user
    params = request.env['omniauth.auth']
    if feed = current_user.twitter
      feed.update_attributes(token: params[:credentials][:token], secret: params[:credentials][:secret])
    else
      @error = t('feed_exists') if SocialMedia.find_by_feed_type_and_uid(4, params[:info][:uid])
      @info = {
        feed_type: 4,
        full_name: params[:info][:name],
        uid: params[:info][:uid],
        username: params[:info][:nickname],
        picture: params[:info][:image],
        token: params[:credentials][:token],
        secret: params[:credentials][:secret]
      }
    end
    render "users/callback"
  end
end
