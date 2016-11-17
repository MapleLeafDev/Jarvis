class ChangeColumnTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :assigned, :string
  end
end
