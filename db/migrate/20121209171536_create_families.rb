class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
