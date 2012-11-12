Given /^I have games titled (.+)$/ do |titles|
  titles.split(', ').each do |t|
    FactoryGirl.create :game, title: t
  end
end

Given /^I have a game titled "(.*?)"$/ do |title|
  FactoryGirl.create :game, title: title
end

When /^I edit game named "(.*?)"$/ do |title|
  within(".game_#{title}") do
    click_link_or_button "Edit"
  end
end

When /^I view game named "(.*?)"$/ do |title|
  within(".game_#{title}") do
    click_link_or_button title
  end
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

Given /^I am on the (.+) page$/ do |page|
  if page == "home"
    visit "/"
  else
    visit "/#{page}"
  end
end

Then /^I click "(.*?)"$/ do |link|
  click_link_or_button link
end

Then /^I fill in "(.*?)" with "(.*?)"$/ do |field, text|
  fill_in field, :with => text
end

Then /^I can edit field with value "(.*?)"$/ do |value|
  assert find_field("game_title").value == value
end

Given /^I am on the (.+) page of "(.*?)"$/ do |type, title|
  game = Game.find_by_title title
  visit "/games/#{game.id}/#{type}"
end


