class SocialMedia < ActiveRecord::Base
  belongs_to :user

  TYPE_NAME = [
    nil,
    "Instagram",
    "Facebook",
    "Tumblr",
    "Twitter"
  ]

  def type_tag
    TYPE_NAME[feed_type]
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

  def self.instagram_redirect_uri
    Rails.env.development? ? "http://localhost:3000/instagram/callback" : "http://www.ml-family.com/instagram/callback"
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

  def self.facebook_redirect_uri
    Rails.env.development? ? "http://localhost:3000/facebook/callback" : "http://www.ml-family.com/facebook/callback"
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

  def twitter_media
    twitter_client(self.token, self.secret).home_timeline
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
      :consumer_key => 'JVfaewA6vSBIbKkL74YkfrmLfbsBnwoItBnSEDEGYgzvQiPnU0',
      :consumer_secret => 'XLWZhgdcYAdYRbs6A3KjSDMhrcsygJkofKF5vHvWRYE5FsVIYE',
      :oauth_token => token,
      :oauth_token_secret => secret
    })
  end

  def twitter_client(token, secret)
    Twitter::REST::Client.new({
      :consumer_key => "bpRzFtxeqooYCBau5qFcz4LHG",
      :consumer_secret => "RDbEHYY19v2FXputsCpQCxwJmLWZiIUSWRCsTuqdBljQQcbhd7",
      :access_token => token,
      :access_token_secret => secret
    })
  end
end
