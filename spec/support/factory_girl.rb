RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# generate sequenced emails
FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@ml-family.com"
  end
end

FactoryGirl.define do
  ######################################
  # Users
  ######################################
  factory :parent, class: User do
    name     "parent"
    password "password"
    pin      "1234"
    email    { generate(:email) }
    parent   true
    dob      { Time.now - 10.days }
  end

  factory :child, class: User do
    name     "child"
    password "password"
    pin      "1234"
    email    { generate(:email) }
    dob      { Time.now - 1.days }
  end

  factory :admin, class: User do
    name     "admin"
    password "password"
    pin      "1234"
    email    "admin@ml-family.com"
    dob      { Time.now - 10.days }
  end

  ######################################
  # Family
  ######################################
  factory :family, class: Family do
    name "testFam"
    url  "testurl"
  end

  ######################################
  # Task
  ######################################
  factory :task, class: Task do
    name  "task"
    daily true
  end
end
