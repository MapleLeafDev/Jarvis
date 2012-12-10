class Family < ActiveRecord::Base
  attr_accessible :name
  has_many :family_members
  has_many :users, :through => :family_members
  
end
