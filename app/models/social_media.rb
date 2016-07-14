class SocialMedia < ActiveRecord::Base
  belongs_to :user

  TYPE_NAME = [
    nil,
    "Instagram",
    "Facebook",
    "Tumblr",
    "Twitter"
  ]

  CSS_NAME = [
    nil,
    "instagram",
    "facebook-square",
    "tumblr-square",
    "twitter-square"
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
    end
  end

  def more_results(id, type = 'profile')
    case feed_type
    when 1
      instagram_media(id)
    when 2
      facebook_media(id)
    when 4
      type == 'recent' ? twitter_media(id) : twitter_user(id)
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

  def self.redirect_url
    "http://#{Rails.env.development? ? request.host_with_port : 'www.ml-family.com'}/#{type_tag.downcase}/callback"
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

  def instagram_media(id = nil)
    instagram_client(self.token).user_recent_media('self', count: 18, max_id: id)
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

  def twitter_user(id = nil)
    options = {count: 200}
    options[:max_id] = (id.to_i - 1) if id
    twitter_client(self.token, self.secret).user_timeline(self.username, options)
  end

  def twitter_media(id = nil)
    options = {count: 200}
    options[:max_id] = (id.to_i - 1) if id
    twitter_client(self.token, self.secret).home_timeline(options)
  end

  def twitter_followers
    twitter_client(self.token, self.secret).followers
  end

  def twitter_following
    twitter_client(self.token, self.secret).friends
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
end
