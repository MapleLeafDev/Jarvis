require "rails_helper"

RSpec.describe Family, :type => :model do
  it "email should return family name" do
    family = build(:family)

    expect(family.email).to eq(family.name)
  end

  it "should return a proper portal url" do
    family = build(:family)

    expect(family.portal_url).to eq("http://www.ml-family.com/my_family/" + family.url)
  end

  it "should return members ordered by date of birth" do
    family = create_family

    expect(family.members).to eq(User.where(family_id: family.id).order(:dob))
  end

  it "should return parents ordered by date of birth" do
    family = create_family

    expect(family.parents).to eq(User.where(family_id: family.id, parent: true).order(:dob))
  end

  it "should return children ordered by date of birth" do
    family = create_family

    expect(family.children).to eq(User.where(family_id: family.id, parent: false).order(:dob))
  end
end
