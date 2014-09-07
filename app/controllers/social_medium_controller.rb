class SocialMediumController < ApplicationController
  respond_to :html, :js
  
  def show
    @feed = SocialMedia.find_by_id(params[:id])
    case @feed.feed_type
    when 1
      @results = @feed.instagram_recent_media
    end
  end
end
