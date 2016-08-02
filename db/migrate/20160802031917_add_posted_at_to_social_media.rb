class AddPostedAtToSocialMedia < ActiveRecord::Migration
  def change
    add_column :social_media, :posted_at, :datetime
  end
end
