class AddLastIdToSocialMedia < ActiveRecord::Migration
  def change
    add_column :social_media, :last_id, :string
  end
end
