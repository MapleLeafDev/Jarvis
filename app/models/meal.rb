class Meal < ActiveRecord::Base
  attr_accessible :name
  has_many :ingredients, dependent: :destroy
end
