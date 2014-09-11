class SocialMedia < ActiveRecord::Base
  belongs_to :user

  TYPE_NAME = [
    nil,
    "Instagram",
    "Facebook"
  ]

  def instagram_tag
    client = instagram_client(self.token)
    client.tag_search('cat')
  end

  def instagram_media(type)
    client = instagram_client(self.token)
    begin
      if type == 'recent'
        client.user_recent_media
      else
        client.user_media_feed(777)
      end
    rescue
      []
    end
  end

  def self.instagram_redirect_uri
    if Rails.env.development?
      "http://localhost:3000/instagram/callback"
    else
      "http://chore-chart.herokuapp.com/instagram/callback"
    end
  end

  private

  def instagram_client(token)
    Instagram.client(access_token: token)
  end
end
