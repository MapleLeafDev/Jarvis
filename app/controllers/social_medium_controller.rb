class SocialMediumController < ApplicationController
  respond_to :html, :js

  def show
    @user = User.find_by_id(params[:user_id])
    @feed = SocialMedia.find_by_id(params[:id])
    case @feed.feed_type
    when 1
      @info = @feed.instagram_info
      @results = @feed.instagram_media
    when 2
      @results = @feed.facebook_media
    end

    respond_to do |format|
      format.js
      # format.js.phone { render template: "social_medium/show_m" }
    end
  end

  def relationships
    @user = User.find_by_id(params[:user_id])
    @feed = SocialMedia.find_by_id(params[:feed_id])
    case @feed.feed_type
    when 1
      @info = @feed.instagram_info
      @results = params[:rel_type] == "following" ? @feed.instagram_following : @feed.instagram_followers
    when 2
      @results = @feed.facebook_media(params[:type])
    end
    respond_to do |format|
      format.js
      # format.js.phone { render template: "social_medium/relationships_m" }
    end
  end

  def more_results
    @user = User.find_by_id(params[:user_id])
    @feed = SocialMedia.find_by_id(params[:feed_id])

    case @feed.feed_type
    when 1
      @results = @feed.instagram_media(params[:id])
    when 2
      @results = @feed.facebook_media(params[:id])
    end

    respond_to do |format|
      format.js
    end
  end

  def instagram_post
    @user = User.find_by_id(params[:user_id])
    @feed = SocialMedia.find_by_id(params[:feed_id])
    @post = @feed.instagram_post(params[:media_id])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @feed = SocialMedia.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to @user }
    end
  end
end
