# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mixed_field do
    developer nil
    company nil
    notFound "MyString"
    additionalInfo "MyString"
    type nil
  end
end
