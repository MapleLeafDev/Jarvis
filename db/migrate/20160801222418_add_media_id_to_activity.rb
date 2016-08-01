class AddMediaIdToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :media_id, :integer
    add_column :activities, :posted_at, :datetime
  end
end
