# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    embedcode "MyText"
    game nil
  end
end
