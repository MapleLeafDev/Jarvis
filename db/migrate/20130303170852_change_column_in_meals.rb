class ChangeColumnInMeals < ActiveRecord::Migration
  def up
    rename_column :meals, :day, :menu_day
  end

  def down
  end
end
