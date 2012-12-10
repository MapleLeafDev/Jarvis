class AddAdminToFamilyMember < ActiveRecord::Migration
  def change
    add_column :family_members, :admin, :boolean

  end
end
