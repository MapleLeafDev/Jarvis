class SocialMediumController < ApplicationController
  respond_to :html, :js
  
  def show
    @user = User.find_by_id(params[:user_id])
    @feed = SocialMedia.find_by_id(params[:id])
    case @feed.feed_type
    when 1
      @results = @feed.instagram_media(params[:type])
    when 2
      @results = @feed.facebook_media(params[:type])
    end

    respond_to do |format|
      format.js 
      format.js.phone { render template: "social_medium/show_m" }
    end
  end
end
