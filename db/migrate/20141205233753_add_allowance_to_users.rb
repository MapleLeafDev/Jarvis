class AddAllowanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :allowance, :integer
  end
end
