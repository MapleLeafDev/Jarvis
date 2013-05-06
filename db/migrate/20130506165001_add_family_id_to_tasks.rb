class AddFamilyIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :family_id, :integer
  end
end
