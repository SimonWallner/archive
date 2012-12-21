# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'loggedin@example.com'
    firstname 'FirstName'
    lastname 'lastname'
    password 'aA1aaaaaa'
    password_confirmation { |u| u.password }

    after(:create) do |user|
      if user.blocked?
        user.toggle!(:blocked)
      end
    end
  end

  factory :confirmed_user, :parent => :user do
    after(:create) do |user|
      user.confirm!
    end
  end

  factory :admin_user, :parent => :confirmed_user do
    after(:create) { |user| user.toggle!(:admin) }
  end
end