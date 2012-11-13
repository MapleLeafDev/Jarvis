class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.datetime :next_date
      t.boolean :daily
      t.boolean :weekly
      t.boolean :monthly
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.integer :period
      t.integer :how_often
      t.datetime :custom_start
      t.integer :points

      t.timestamps
    end
  end
end
