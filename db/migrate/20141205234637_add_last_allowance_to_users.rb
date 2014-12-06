class AddLastAllowanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_allowance, :datetime
  end
end
