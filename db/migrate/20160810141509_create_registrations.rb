class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :family_id
      t.integer :cource_id
      t.string :email
      t.string :card_token
      t.string :customer_id
      t.date :end_date
      t.timestamps
    end
  end
end
