class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth['uid']
      user.username = auth['info']['email']
    end
  end
end
