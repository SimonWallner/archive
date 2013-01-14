# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name "MyString"
    description "MyText"
    version_id "versionid"
    version_number 1
    version_updated_at Time.now
  end
end
