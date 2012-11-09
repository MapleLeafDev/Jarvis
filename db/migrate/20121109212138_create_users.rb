class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :facebook_id
      t.string :thumbnail
      t.integer :parent_id
      t.integer :theme_id

      t.timestamps
    end
  end
end
