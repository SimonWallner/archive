# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :field do
    name "MyString"
    content "MyText"
    game nil
    company nil
    developer nil
  end
end
