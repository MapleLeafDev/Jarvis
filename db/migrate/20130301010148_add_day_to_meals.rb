class AddDayToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :day, :integer
  end
end
