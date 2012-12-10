class FamilyMember < ActiveRecord::Base
  attr_accessible :family_id, :user_id, :admin
  belongs_to :family
  belongs_to :user
end
