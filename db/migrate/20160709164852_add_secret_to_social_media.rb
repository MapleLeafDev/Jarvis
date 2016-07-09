class AddSecretToSocialMedia < ActiveRecord::Migration
  def change
    add_column :social_media, :secret, :string
  end
end
