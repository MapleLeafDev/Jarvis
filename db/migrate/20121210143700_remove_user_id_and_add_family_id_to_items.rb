class RemoveUserIdAndAddFamilyIdToItems < ActiveRecord::Migration
  def up
    remove_column :items, :user_id
    add_column :items, :family_id, :integer
  end

  def down
  end
end
