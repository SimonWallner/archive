Given /^I have games titled (.+)$/ do |titles|
  titles.split(', ').each do |t|
    FactoryGirl.create :game, title: t
  end
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

Given /^I am on the games page$/ do
  visit '/games'
end

Given /^I am on the home page$/ do
  visit '/'
end

Then /^I go to the (.+) page$/ do |page|
  click_link page
end

Then /^I click "(.*?)"$/ do |link|
  click_link link

end

Then /^I fill in "(.*?)" with "(.*?)"$/ do |field, text|
  fill_in field, :with => text
end

Then /^I am on the game's page "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end