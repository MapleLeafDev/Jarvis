class SocialMedia < ActiveRecord::Base
  belongs_to :user

  TYPE_NAME = [
    nil,
    "Instagram",
    "Facebook",
    "Tumblr"
  ]

  def type_tag
    TYPE_NAME[feed_type]
  end

  ###################
  # Instagram
  ###################
  def instagram_info
    token = self.token
    id = token.split('.')[0]
    url = "https://api.instagram.com/v1/users/#{id}/?access_token=#{token}"
    begin
      response = RestClient.get url
      parsed = JSON::parse(response)
      results = parsed['data']
    rescue
      []
    end
    results
  end

  def instagram_following
    token = self.token
    id = token.split('.')[0]
    continue = true
    url = "https://api.instagram.com/v1/users/#{id}/follows?access_token=#{token}"
    results = []
    begin
      while continue
        puts url
        response = RestClient.get url
        parsed = JSON::parse(response)
        results += parsed['data']
        if parsed['pagination']['next_url'].present?
          url = parsed['pagination']['next_url']
        else
          continue = false
        end
      end
    rescue
      []
    end
    results
  end

  def instagram_followers
    token = self.token
    id = token.split('.')[0]
    continue = true
    url = "https://api.instagram.com/v1/users/#{id}/followed-by?access_token=#{token}"
    results = []
    begin
      while continue
        response = RestClient.get url
        parsed = JSON::parse(response)
        results += parsed['data']
        if parsed['pagination']['next_url'].present?
          url = parsed['pagination']['next_url']
        else
          continue = false
        end
      end
    rescue
      []
    end
    results
  end

  def instagram_media(id = nil)
    client = instagram_client(self.token)
    client.user_recent_media(count: 18, max_id: id)
  end

  def instagram_post(id)
    client = instagram_client(self.token)
    client.media_item(id)
  end

  def self.instagram_redirect_uri
    if Rails.env.development?
      "http://localhost:3000/instagram/callback"
    else
      "http://www.ml-family.com/instagram/callback"
    end
  end

  ###################
  # Facebook
  ###################
  def facebook_info
    client = facebook_client(self.token)
    client.get_object("me")
  end

  def facebook_media(type = nil)
    client = facebook_client(self.token)
    begin
      if type == 'recent'
        []
      else
        client.get_connections("me","feed")
      end
    rescue
      []
    end
  end

  def self.facebook_redirect_uri
    if Rails.env.development?
      "http://localhost:3000/facebook/callback"
    else
      "http://www.ml-family.com/facebook/callback"
    end
  end

  ###################
  # Tumblr
  ###################
  def tumblr_media(type = nil)
    client = tumblr_client(self.token)
    begin
      if type == 'recent'
        [] #client.user_recent_media
      else
        client.get_connections("me","feed")
      end
    rescue
      []
    end
  end

  private

  def instagram_client(token)
    Instagram.client(access_token: token)
  end

  def facebook_client(token)
    Koala::Facebook::API.new(token)
  end

  def self.tumblr_client(token)
    Tumblr::Client.new({
      :consumer_key => 'JVfaewA6vSBIbKkL74YkfrmLfbsBnwoItBnSEDEGYgzvQiPnU0',
      :consumer_secret => 'XLWZhgdcYAdYRbs6A3KjSDMhrcsygJkofKF5vHvWRYE5FsVIYE',
      :oauth_token => token,
      :oauth_token_secret => secret
    })
  end
end
