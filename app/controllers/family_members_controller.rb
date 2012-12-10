class FamilyMembersController < ApplicationController

  def make_parent
    @user = User.find_by_id(params[:user_id])
    membership = FamilyMember.find_by_user_id(@user.id)
    if membership
      membership.admin = true
      membership.save
    end
  end

  def remove_parent
    @user = User.find_by_id(params[:user_id])
    membership = FamilyMember.find_by_user_id(@user.id)
    if membership
      membership.admin = false
      membership.save
    end
  end
end