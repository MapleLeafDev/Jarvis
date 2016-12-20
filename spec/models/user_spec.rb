require "rails_helper"

RSpec.describe User, :type => :model do
  it "parent? should return true if parent" do
    user = User.new(parent: true)

    expect(user.parent?).to eq(true)
  end

  it "child? should return true if not a parent" do
    user = User.new(parent: false)

    expect(user.child?).to eq(true)
  end
end
