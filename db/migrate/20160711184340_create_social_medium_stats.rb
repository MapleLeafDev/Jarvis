class CreateSocialMediumStats < ActiveRecord::Migration
  def change
    create_table :social_medium_stats do |t|
      t.integer :user_id
      t.string :instagram
      t.string :facebook
      t.string :twitter

      t.timestamps
    end
  end
end
