class Ingredient < ActiveRecord::Base
  attr_accessible :name, :category, :quantity, :meal_id
  belongs_to :meal
end
