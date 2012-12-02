class Item < ActiveRecord::Base
  attr_accessible :name, :thumbnail, :price, :description
  has_many :purchases
  validates_presence_of :name, :price, :description
end
