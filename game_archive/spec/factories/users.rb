# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    firstname 'FirstName'
    lastname 'lastname'
    password 'aA1aaaaaa'
    password_confirmation { |u| u.password }
  end

  factory :confirmed_user, :parent => :user do
    after(:create) { |user| user.confirm! }
  end
end