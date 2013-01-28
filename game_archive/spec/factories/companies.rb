# Read about factories at https://github.com/thoughtbot/factory_girl
require 'securerandom'

FactoryGirl.define do
  factory :company do
    name "MyString"
    description "MyText"
    version_id { SecureRandom.uuid.to_s }
    version_number 1
    version_updated_at Time.now
  end
end
