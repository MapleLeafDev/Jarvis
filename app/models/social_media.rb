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

  def instagram_recent_media
    client = instagram_client(self.token)
    begin
      client.user_recent_media
    rescue
      []
    end
  end

  private

  def instagram_client(token)
    Instagram.client(access_token: token)
  end
end
