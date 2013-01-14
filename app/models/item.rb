class Item < ActiveRecord::Base
  attr_accessible :name, :thumbnail, :price, :description, :used_by
  has_many :purchases
  validates_presence_of :name, :price, :description, :used_by
end
