# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reportblockcontent do
    content_type 1
    content_id 1
    status 1
    reason "MyString"
    email "MyString"
    admin_id 1
  end
end
