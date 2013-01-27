class Meal < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :ingredients
  validates_uniqueness_of :name
end
