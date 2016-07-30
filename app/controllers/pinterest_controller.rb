class PinterestController < ApplicationController

  def connect
    redirect_to "/auth/pinterest"
  end

  def callback
    params = request.env['omniauth.auth']
    puts params
    unless current_user.pinterest?
      current_user.social_medium.create(
        feed_type: 6,
        full_name: "#{params[:info][:first_name]} #{params[:info][:last_name]}",
        uid: params[:info][:id]
        )
    end
    redirect_to "/profile"
  end
end
