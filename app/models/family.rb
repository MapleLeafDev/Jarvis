class Family < ActiveRecord::Base
  attr_accessible :name
  has_many :family_members, :dependent => :destroy
  has_many :users, :through => :family_members
  
  validates_presence_of :name
  validates_uniqueness_of :url

end
