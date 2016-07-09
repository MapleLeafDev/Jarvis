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
    client = instagram_client(self.token)
    client.user
  end

  def instagram_following
    client = instagram_client(self.token)
    client.user_follows
  end

  def instagram_followers
    client = instagram_client(self.token)
    client.user_followed_by
  end

  def instagram_media(id = nil)
    client = instagram_client(self.token)
    client.user_recent_media('self', count: 18, max_id: id)
  end

  def instagram_post(id)
    client = instagram_client(self.token)
    client.media_item(id)
  end

  def self.instagram_redirect_uri
    Rails.env.development? ? "http://localhost:3000/instagram/callback" : "http://www.ml-family.com/instagram/callback"
  end

  ###################
  # Facebook
  ###################
  def facebook_info
    client = facebook_client(self.token)
    client.get_object("me", api_version: 'v2.0')
  end

  def facebook_friends
    client = facebook_client(self.token)
    client.get_connections("me", "friends", api_version: 'v2.0')
  end

  def facebook_media(type = nil)
    client = facebook_client(self.token)
    client.get_connections("me", "feed", api_version: 'v2.0')
  end

  def self.facebook_redirect_uri
    Rails.env.development? ? "http://localhost:3000/facebook/callback" : "http://www.ml-family.com/facebook/callback"
  end

  ###################
  # Tumblr
  ###################
  def tumblr_media(type = nil)
    client = tumblr_client(self.token)
    client.get_connections("me","feed")
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
    Twitter::REST::Client.new do |config|
      config.consumer_key = 'PprUn42LGaxlA7GQw1xSPMzny'
      config.consumer_secret = 'enxaX79YMvwptSH0ikeTclFBc3Y36vUOUKx1RjwADDE5cPWNBa'
      config.bearer_token = token
    end
  end
end
