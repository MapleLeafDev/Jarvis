class RemoveColumnsFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :type
    remove_column :users, :thumbnail
    remove_column :users, :parent_id
  end

  def down
  end
end