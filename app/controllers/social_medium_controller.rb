class SocialMediumController < ApplicationController
  before_filter :load_objects
  respond_to :html, :js

  def show
    @info = @feed.info
    @results = @feed.media(params[:type])
  end

  def relationships
    @feed.info
    @results = @feed.relationships(params[:relationship_type])
  end

  def more_results
    @results = @feed.more_results(params[:media_id])
  end

  def instagram_post
    @post = @feed.instagram_post(params[:media_id])
    @comments = @feed.comments(params[:media_id])
  end

  def twitter_post
    @post = @feed.twitter_post(params[:media_id]).first
  end

  def disable
    @feed.destroy
    redirect_to user_path(@user)
  end

  def record
    @user.family.users.each do |member|
      member.social_medium.each do |sm|
        SocialMedia.record(sm.id)
      end
    end
    @activities = @user.family.activities.order('posted_at desc')
  end

  private

  def load_objects
    @user = User.find_by_id(params[:user_id])
    @feed = SocialMedia.find_by_id(params[:id] || params[:feed_id])
  end
end
