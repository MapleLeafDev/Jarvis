class ChangeMediaIdActivities < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.change :media_id, :string
    end
  end
end
