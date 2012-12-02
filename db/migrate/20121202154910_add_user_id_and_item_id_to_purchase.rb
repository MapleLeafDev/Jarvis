class AddUserIdAndItemIdToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :user_id, :integer

    add_column :purchases, :item_id, :integer

  end
end
