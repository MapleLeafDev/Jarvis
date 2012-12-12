class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :theme_id, :email, :user_type, :pin, :password, :password_confirmation
  has_one :family_member, :dependent => :destroy
  has_one :family, :through => :family_member
  has_many :tasks, :dependent => :destroy
  has_many :completions, :dependent => :destroy
  has_many :purchases, :dependent => :destroy
  validates_presence_of :name
end