##################################
#
# visiting
#
##################################

## general
When /^I am on the Home Page$/ do
  visit_home_page
end

Given /^I am on the home page$/ do
  visit_home_page
end

## companies
Given /^I am on the company creation page$/ do
  visit_company_creation_page
end

Given /^I am on the companies overview page$/ do
  visit_companies_overview_page
end

Given /^I am on the detail page of the given company$/ do
  visit_company_detail_page @givenCompany
end

Given /^I am on the edit page of the given company$/ do
  visit_company_edit_page @givenCompany
end

## developers
Given /^I am on the developers overview page$/ do
  visit_developers_overview_page
end

Given /^I am on the developer creation page$/ do
  visit_developer_creation_page
end

Given /^I am on the detail page of the given developer$/ do
  visit_developer_page @givenDeveloper
end

Given /^I am on the edit page of the given developer$/ do
  visit_developer_edit_page @givenDeveloper
end

## games
When /^I am on the Games Overview Page$/ do
  visit_games_overview_page
end

Given /^I am on the games overview page$/ do
  visit_games_overview_page
end

Given /^I am on the game creation page$/ do
  visit_game_creation_page
end

Given /^I am on the edit page of the given game$/ do
  visit_game_edit_page @givenGame
end

Given /^I am on the detail page of the game$/ do
  visit_game_page @givenGame
end

## genre
Given /^I am on the genre create page$/ do
  visit_genre_creation_page
end

Given /^I am on the genres page$/ do
  visit_genres_overview_page
end

Given /^I am on the edit page of the genre$/ do
  visit_genre_edit_page @genre
end

## users
Given /^I am on the user edit page$/ do
  visit_user_edit_page
end

Given /^I am on the login page$/ do
  visit_login_page
end

When /^I go to the sign up form$/ do
  visit_sign_up_form @user
end

When /^I enter the invitation url$/ do
   visit_user_invitation_page
end

Given /^I am on the reset password page$/ do
  visit_reset_password_page
end

When /^I enter the promote admin page adress$/ do
  visit_manage_admin_page
end

When /^I follow the reset link$/ do
  visit_reset_link @user
end

When /^I enter edit user url$/ do
  visit_user_edit_page
end

Then /^I should be redirected to the sign in page$/ do
  on_login_page
  #URI.parse(current_url).path.should == "/users/sign_in"
end

##################################
#
# checking if on a special site
#
##################################

## users
Then /^I should be on the user edit page$/ do
  on_user_edit_page
end

Then /^I should be on the reset password page$/ do
  on_reset_password_page
end

Then /^I should be on the sign up page$/ do
  on_sign_up_page
end

Then /^I should be on the invite page$/ do
  on_invite_page
end

Then /^I should be on the password page$/ do
  on_password_page
end

Then /^I should be on the promote admin page$/ do
  on_manage_admin_page
end

## games
Then /^I should be on the detail page of the given game$/ do
  on_game_detail_page @givenGame
end

## developers
Then /^I should be on the detail page of the given developer$/ do
  on_developer_detail_page @givenDeveloper
end

## companies
Then /^I should be on the detail page of the given company$/ do
  on_company_detail_page @givenCompany
end