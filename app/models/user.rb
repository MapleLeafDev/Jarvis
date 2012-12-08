class User < ActiveRecord::Base
  attr_accessible :name, :facebook_id, :thumbnail, :parent_id, :theme_id, :email
  has_many :tasks, :dependent => :destroy
  has_many :completions, :dependent => :destroy
  has_many :purchases, :dependent => :destroy
  validates_presence_of :name

  def self.create_with_omniauth(auth)
    create! do |user|
      user.facebook_id = auth['uid']
      user.name = auth['info']['name']
      user.thumbnail = auth['info']['image']
    end
  end
end
