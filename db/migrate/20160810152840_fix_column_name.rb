class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :registrations, :cource_id, :course_id
  end
end
