#   Scenario: show game's page
Given /^I have a game (.+)$/ do |game_name|
  @givenGame=FactoryGirl.create :game , title:game_name
end
And /^I am on the games overview page$/ do
  visit games_path
end
Then /^I should see the title of the game in a list of games$/ do
  page.should have_content(@givenGame.title)
end



#   Scenario: create game and genres with valid data
When /^I follow the new game link$/ do
  click_link_or_button "New Game"
end
When /^I fill in the fields of game and genres with valid details and submit it$/ do


  @newGame=FactoryGirl.create :game , title:"Mario" , description:"awesome"
  @newGenre=FactoryGirl.create :genre , name:"Jump and Run"


  fill_in("game_title", :with => @newGame.title)
  fill_in("game_description", :with => @newGame.description)
  fill_in("new_genres", :with => @newGenre.name)
  #select('genre1', :from => "game_genre_ids")
  click_button "Create Game"

end


Then /^I should see the details of the newly created game$/ do
  page.should have_content(@newGame.title)
  page.should have_content(@newGame.description)
  page.should have_content(@newGenre.name)

end



#   Scenario: fail to create game with empty name
Given /^I am on the game creation page$/ do
  visit new_game_path
end
When /^I leave the name of games  field empty and submit it$/ do
  fill_in("game_title", :with => "")
  fill_in("game_description", :with => "")
  fill_in("new_genres", :with => "")
  #select('genre1', :from => "game_genre_ids")
  click_button "Create Game"
end
Then /^I should be notified of that the name of game must not be empty$/ do
  page.should have_content("Title can't be blank")
end




#   Scenario: update game's page with valid data
Given /^I am on the detail page of the game$/ do
  visit game_path(@givenGame)
end


When /^I follow the edit link of game page$/ do
  click_link_or_button "Edit"
end
And /^I change the game's data and submit it$/ do

  @givenGame.title="newGameTitle"
  @givenGame.description= "newGameDesc"
  @givenGenre=FactoryGirl.create :genre , name:"Jump and Run and Hit"


  fill_in("game_title", :with => @givenGame.title)
  fill_in("game_description", :with => @givenGame.description)
  fill_in("new_genres", :with => @givenGenre.name)
  #select('genre3', :from => "game_genre_ids")
  click_button "Update Game"


end
Then /^I should be on the game's page$/ do
  visit "/games/#{@givenGame.id}"
end
Then /^I should see the updated game content$/ do
  page.should have_content(@givenGame.title)
  page.should have_content(@givenGame.description)
  page.should have_content(@givenGenre.name)
  #select('genre3', :from => "game_genre_ids")
end

