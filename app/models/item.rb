class Item < ActiveRecord::Base
  has_many :purchases
  validates_presence_of :name, :price, :description, :used_by
end
