class AddUidToSocialMedia < ActiveRecord::Migration
  def change
    add_column :social_media, :uid, :string
  end
end
