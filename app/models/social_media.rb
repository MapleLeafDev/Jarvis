class SocialMedia < ActiveRecord::Base
  belongs_to :user

  TYPE_NAME = [
    nil,
    "Instagram",
    "Facebook",
    "Tumblr",
    "Twitter",
    "Google",
    "Pinterest"
  ]

  CSS_NAME = [
    nil,
    "instagram",
    "facebook-square",
    "tumblr-square",
    "twitter-square",
    "google-plus-square",
    "pinterest-square"
  ]

  def type_tag
    TYPE_NAME[feed_type]
  end

  def css_class
    CSS_NAME[feed_type]
  end

  ###################
  # Generic Commands
  ###################
  def info
    case feed_type
    when 1
      instagram_info
    when 2
      facebook_info
    when 4
      twitter_info
    when 5
      google_info
    when 6
      pinterest_info
    end
  end

  def media(type = 'profile')
    case feed_type
    when 1
      instagram_media
    when 2
      facebook_media
    when 4
      type == 'recent' ? twitter_media : twitter_user
    when 5
      google_media
    when 6
      pinterest_media
    end
  end

  def comments(id)
    case feed_type
    when 1
      instagram_comments(id)
    end
  end

  def more_results(id, type = 'profile')
    case feed_type
    when 1
      instagram_media(max_id: id)
    when 2
      facebook_media(id)
    when 4
      type == 'recent' ? twitter_media(id) : twitter_user(max_id: id)
    end
  end

  def relationships(type)
    case feed_type
    when 1
      type == "following" ? instagram_following : instagram_followers
    when 2
      facebook_friends
    when 4
      type == "following" ? twitter_following : twitter_followers
    end
  end

  def self.redirect_url(type)
    "http://#{Rails.env.development? ? 'localhost:3000' : 'www.ml-family.com'}/#{SocialMedia::TYPE_NAME[type].downcase}/callback"
  end

  def self.record(id)
    feed = SocialMedia.find(id)
    posts = []
    new_last_id = nil

    case feed.feed_type
    when 1
      posts = feed.instagram_media(min_id: feed.last_id)
    when 4
      posts = feed.twitter_user(min_id: feed.last_id)
    end

    posts.reverse.each do |post|
      case feed.feed_type
      when 1
        posted_at = Time.at(post.created_time.to_i)
        new_last_id = post.id.to_s
      when 4
        posted_at = post.created_at
        new_last_id = post.id.to_s
      end
      
      unless Activity.find_by_media_id(new_last_id)
        Activity.create(family_id: feed.user.family_id, user_id: feed.user_id, type_id: feed.feed_type, media_id: new_last_id, posted_at: posted_at)
      end
    end

    feed.update_attribute(:last_id, new_last_id) if new_last_id
  end

  ###################
  # Instagram
  ###################
  def instagram_info
    instagram_client(self.token).user
  end

  def instagram_following
    instagram_client(self.token).user_follows
  end

  def instagram_followers
    instagram_client(self.token).user_followed_by
  end

  def instagram_media(params = {})
    instagram_client(self.token).user_recent_media('self', count: params[:count], max_id: params[:max_id], min_id: params[:min_id])
  end

  def instagram_comments(id)
    instagram_client(self.token).media_comments(id)
  end

  def instagram_likes(id = nil)
    instagram_client(self.token).user_liked_media(count: 18, max_id: id)
  end

  def instagram_post(id)
    instagram_client(self.token).media_item(id)
  end

  ###################
  # Facebook
  ###################
  def facebook_info
    facebook_client(self.token).get_object("me", api_version: 'v2.0')
  end

  def facebook_friends
    facebook_client(self.token).get_connections("me", "friends", api_version: 'v2.0')
  end

  def facebook_media(type = nil)
    facebook_client(self.token).get_connections("me", "feed", api_version: 'v2.0')
  end

  ###################
  # Tumblr
  ###################
  def tumblr_media(type = nil)
    tumblr_client(self.token).get_connections("me","feed")
  end

  ###################
  # Twitter
  ###################
  def twitter_info
    twitter_client(self.token, self.secret).user(self.username)
  end

  def twitter_user(params = {})
    options = {count: 100}
    options[:max_id] = (params[:max_id].to_i - 1) if params[:max_id]
    options[:since_id] = (params[:min_id].to_i + 1) if params[:min_id]
    twitter_client(self.token, self.secret).user_timeline(self.username, options)
  end

  def twitter_media(id = nil)
    options = {count: 100}
    options[:max_id] = (id.to_i - 1) if id
    twitter_client(self.token, self.secret).home_timeline(options)
  end

  def twitter_followers
    twitter_client(self.token, self.secret).followers
  end

  def twitter_following
    twitter_client(self.token, self.secret).friends
  end

  def twitter_post(id)
    options = {count: 1}
    options[:max_id] = id.to_i
    twitter_client(self.token, self.secret).user_timeline(self.username, options)
  end

  ###################
  # Google +
  ###################
  def google_info
    GooglePlus::Person.get(self.uid)
  end

  def google_media(id = nil)
    GooglePlus::Person.get(self.uid).list_activities.items
  end

  ###################
  # Pinterest
  ###################
  def pinterest_info
    pinterest_client.get_user(self.uid, {fields: 'first_name,id,last_name,url,bio,username,counts,account_type,created_at,image'})
  end

  def pinterest_media(id = nil)
    []
  end

  private

  def instagram_client(token)
    Instagram.client(access_token: token)
  end

  def facebook_client(token)
    Koala::Facebook::API.new(token)
  end

  def tumblr_client(token, secret)
    Tumblr::Client.new({
      :consumer_key => ENV['TUMBLR_ID'],
      :consumer_secret => ENV['TUMBLR_SECRET'],
      :oauth_token => token,
      :oauth_token_secret => secret
    })
  end

  def twitter_client(token, secret)
    Twitter::REST::Client.new({
      :consumer_key => ENV['TWITTER_ID'],
      :consumer_secret => ENV['TWITTER_SECRET'],
      :access_token => token,
      :access_token_secret => secret
    })
  end

  def pinterest_client
    Pinterest::Client.new(ENV['PINTEREST_KEY'])
  end
end
