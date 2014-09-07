class SocialMediumController < ApplicationController
  respond_to :html, :js
  
  def show
    @feed = SocialMedia.find_by_id(params[:id])
    case @feed.feed_type
    when 1
      @results = @feed.instagram_recent_media
    end

    respond_to do |format|
      format.js 
      format.js.phone { render template: "social_medium/show_m" }
    end
  end
end
