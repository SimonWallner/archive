
When /^I follow the new game link$/ do
  click_link_or_button "New Game"
end

When /^I follow the new developer link$/ do
  click_link_or_button "New Developer"
end

When /^I follow the new company link$/ do
  click_link_or_button "New Company"
end

Given /^I am on the edit page of the given developer$/ do
  visit edit_developer_path(@givenDeveloper)
end

Given /^I am on the edit page of the given company$/ do
  visit edit_company_path(@givenCompany)
end

Given /^I am on the edit page of the given game$/ do
  visit edit_game_path(@givenGame)
end

Given /^I am on the home page$/ do
  visit "/"
end

Given /^I am on the genre create page$/ do
  visit new_genre_path
end

Given /^I am on the companies overview page$/ do
  visit companies_path
end

Given /^I am on the developers overview page$/ do
  visit developers_path
end

Given /^I am on the games overview page$/ do
  visit games_path
end
Given /^I am on the game creation page$/ do
  visit new_game_path
end


Given /^I am on the genres page$/ do
  visit genres_path
end


When /^I fill in the fields with valid details for a (.+)$/ do |type|

  fill_in_name(type)

end

When /^I submit it$/ do

  submit_any_button

end