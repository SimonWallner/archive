# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    title "New Game"
    description "new game description"
    version_id "versionid"
    version_number 1
    version_updated_at Time.now
  end
end
