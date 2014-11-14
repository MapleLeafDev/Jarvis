class ChangeMealColumns < ActiveRecord::Migration
  def change
    change_column :meals, :menu_day, :string
    remove_column :meals, :user_id
    add_column :meals, :family_id, :integer
  end
end
