# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :release_date do
    year 1
    month 1
    day 1
    additional_info "MyString"
    game nil
  end
end
