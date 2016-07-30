class PinterestController < ApplicationController

  def connect
    redirect_to "/auth/pinterest"
  end

  def callback
    params = request.env['omniauth.auth']
    puts "PARAMS -> #{params}"
    if feed = current_user.pinterest
      feed.update_attributes(token: params[:credentials][:token], secret: params[:credentials][:secret])
    else
      current_user.social_medium.create(
        feed_type: 4,
        full_name: "#{params[:info][:first_name]} #{params[:info][:last_name]}",
        uid: params[:info][:id],
        username: params[:info][:nickname],
        token: params[:credentials][:token],
        secret: params[:credentials][:secret]
        )
    end
    redirect_to current_user
  end
end
