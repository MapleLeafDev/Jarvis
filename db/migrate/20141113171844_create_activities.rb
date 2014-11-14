class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :family_id
      t.integer :type_id
      t.string :message

      t.timestamps
    end
  end
end
