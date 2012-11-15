#   Scenario: show game's page
Given /^I have a game$/ do
  @theGame=FactoryGirl.create :game , title:"Tetris"
end
And /^I am on the game page$/ do
  visit "/#{"games"}"
end
Then /^I should see the details of this game$/ do
  page.should have_content(@theGame.title)
end



#   Scenario: create game and genres with valid data
Given /^I am on the game overview page$/ do
  visit "/#{"games"}"
end
When /^I follow the new game link$/ do
  click_link_or_button "New Game"
end
When /^I fill in the fields of game and genres with valid details and submit it$/ do
  fill_in("game_title", :with => "Mario")
  fill_in("game_description", :with => "DescMario")
  fill_in("new_genres", :with => "GenreMario")
  #select('genre1', :from => "game_genre_ids")
  click_button "Create Game"
  @newGame=FactoryGirl.create :game , title:"Mario" , description:"DescMario"
  @newGenre=FactoryGirl.create :genre , name:"GenreMario"
end
Then /^the game should have been created$/ do
  page.should have_content("Game was successfully created.")
end
Then /^I should on the game's page$/ do
  visit "/games/#{@newGame.id}"
end



#   Scenario: fail to create game with empty name
Given /^I am on the game creation page$/ do
  visit(new_game_path)
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
Given /^I have a game name$/ do
  @updateGame=FactoryGirl.create :game , title:"Mario1" , description:"DescMario1"
  @updateGenre=FactoryGirl.create :genre , name:"GenreMario1"

end
Given /^I am on this game's page$/ do
  visit "/games/#{@updateGame.id}"
end
Given /^I follow the edit link of game page$/ do
  click_link_or_button "Edit"
  visit "/games/#{@updateGame.id}/#{"edit"}"
end
When /^I change the game's data and submit it$/ do
  fill_in("game_title", :with => "newGameTitle")
  fill_in("game_description", :with => "newGameDesc")
  fill_in("new_genres", :with => "newGenre")
  #select('genre3', :from => "game_genre_ids")
  click_button "Update Game"
  @updateGame.title="newGameTitle"
  @updateGame.description= "newGameDesc"
  @updateGenre.name="newGenre"

end
Then /^I should be on the game's page$/ do
  visit "/games/#{@updateGame.id}"
end
Then /^I should see the updated game content$/ do
  page.has_xpath?('.//p[@id="notice"]', :text => 'Game was successfully updated.')
  page.should have_content( @updateGame.title)
  page.should have_content(@updateGame.description)
  page.should have_content(@updateGenre.name)
  #select('genre3', :from => "game_genre_ids")
end


