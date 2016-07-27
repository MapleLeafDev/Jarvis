class AddTimezoneToUser < ActiveRecord::Migration
  def change
    unless column_exists?(:users, :timezone)
      add_column :users, :timezone, :string
    end
  end
end
