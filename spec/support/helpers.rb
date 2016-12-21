module SpecTestHelper
  ######################################
  # Login
  ######################################
  def login_admin
    create(:admin) unless User.find_by_name('admin')
    login(:admin)
  end

  def login(user)
    user = User.find_by_name(user.to_s) if user.is_a?(Symbol)
    request.session[:user_id] = user.id
  end

  def current_user
    User.find(request.session[:user_id])
  end

  ######################################
  # Family
  ######################################
  def create_family
    unless family = Family.find_by_name("testFam")
      family = create(:family)
      parent1 = create(:parent, family_id: family.id)
      parent2 = create(:parent, family_id: family.id)
      child1  = create(:child, family_id: family.id)
      child2  = create(:child, family_id: family.id)
    end
    return family
  end
end

RSpec.configure do |config|
  config.include SpecTestHelper
end
