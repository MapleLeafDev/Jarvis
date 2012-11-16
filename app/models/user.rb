class User < ActiveRecord::Base
  attr_accessible :name, :facebook_id, :thumbnail, :parent_id, :theme_id
  has_many :tasks
  has_many :completions
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.facebook_id = auth['uid']
      user.name = auth['info']['name']
      user.thumbnail = auth['info']['image']
    end
  end
end
