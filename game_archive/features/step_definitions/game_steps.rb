#   Scenario: show game's page
Given /^I have a game and genre$/ do
  FactoryGirl.create :game , title:"Tetris"
  FactoryGirl.create :genre , name:"genre1"
end
And /^I am on the game page$/ do
  visit "/#{"games"}"
end
Then /^I should see the details of this game$/ do
  page.should have_content(@title)
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
  fill_in("game_description", :with => "Desc: Mario")
  fill_in("new_genres", :with => "Genre: Mario")
  #select('genre1', :from => "game_genre_ids")
  click_button "Create Game"
end
Then /^the game should have been created$/ do
  page.should have_content("Game was successfully created.")
end
Then /^I should on the game's page$/ do
  @game = Game.find_by_title "Mario"
  visit "/games/#{@game.id}"
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
  FactoryGirl.create :game , title:"Tetris2"
  FactoryGirl.create :genre , name:"genre2"
  @tetris=Game.find_by_title "Tetris2"
end
Given /^I am on this game's page$/ do
  visit "/games/#{@tetris.id}"
end
Given /^I follow the edit link of game page$/ do
  click_link_or_button "Edit"
  visit "/games/#{@tetris.id}/#{"edit"}"
end
When /^I change the game's data and submit it$/ do
  fill_in("game_title", :with => "updateGameTitle")
  fill_in("game_description", :with => "updateGameDesc")
  fill_in("new_genres", :with => "updateGenre")
  #select('genre3', :from => "game_genre_ids")
  click_button "Update Game"
end
Then /^I should be on the game's page$/ do
  visit "/games/#{@tetris.id}"
end
Then /^I should see the updated game content$/ do
  page.has_xpath?('.//p[@id="notice"]', :text => 'Game was successfully updated.')
  page.should have_content("updateGameTitle")
  page.should have_content("updateGameDesc")
  page.should have_content("updateGenre")
  #select('genre3', :from => "game_genre_ids")
end


