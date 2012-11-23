# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    firstname 'FirstName'
    lastname 'lastname'
    password 'please'
    password_confirmation { |u| u.password }
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end