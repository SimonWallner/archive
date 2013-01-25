#   Scenario: show game's page
Given /^I have a game (.*)$/ do |game_name|
  @givenGame=FactoryGirl.create :game , title:game_name

end

Given /^I have a screenshot to the given game$/ do

    visit edit_game_path(@givenGame)

    fill_in_name("game")
    @filename = choose_filename_by_type("valid")
    attach_screenshot(@filename)
    submit_any_button

end

Then /^I should see the title of the game in a list of games$/ do
  page.should have_content(@givenGame.title)
end

#   Scenario: create game and genres with valid data

When /^I fill in the fields of game and genres with valid details and submit it$/ do 
  @new_game_title="Mario"
  @new_game_description= "awesome"  
  fill_in("game_title", :with => @new_game_title)
  fill_in("game_description", :with => @new_game_description)  
  click_button "Create Game"
end


Then /^I should see the details of the newly created game$/ do
  page.should have_content(@new_game_title)
  page.should have_content(@new_game_description) 
end

#   Scenario: fail to create game with empty name

When /^I leave the name of games field empty and submit it$/ do
  fill_in("game_title", :with => "")
  fill_in("game_description", :with => "")
 
  click_button "Create Game"
end
Then /^I should be notified of that the name of game must not be empty$/ do
  page.should have_content("Title can't be blank")
end

When /^I set the name of games field empty and submit it$/ do
  fill_in("game_title", :with => "")
  fill_in("game_description", :with => "")
 
  click_button "Update Game"
end


#   Scenarios: update game's page

When /^I follow the game edit link$/ do
    click_link_or_button "Edit"
end

When /^I change the game's data and submit it$/ do

  @update_game_title="newGameTitle"
  @update_game_description= "newGameDesc"
  fill_in("game_title", :with => @update_game_title)
  fill_in("game_description", :with =>  @update_game_description) 
  click_button "Update Game"
end
Then /^I should see the updated game content$/ do
  page.should have_content(@update_game_title)
  page.should have_content(@update_game_description)
end




