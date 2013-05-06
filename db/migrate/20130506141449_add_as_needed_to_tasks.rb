class AddAsNeededToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :as_needed, :boolean
  end
end
