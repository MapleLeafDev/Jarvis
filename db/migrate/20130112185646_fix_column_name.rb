class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :items, :type, :used_by
  end

  def down
  end
end
