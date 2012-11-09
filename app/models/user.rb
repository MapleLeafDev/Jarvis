class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      user.facebook_id = auth['uid']
      user.name = auth['info']['name']
      user.thumbnail = auth['info']['image']
    end
  end
end
