class Meal < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :ingredients, dependent: :destroy
end
