#   Scenario: show game's page
Given /^I have a game (.+)$/ do |game_name|
  @givenGame=FactoryGirl.create :game , title:game_name
end

Then /^I should see the title of the game in a list of games$/ do
  page.should have_content(@givenGame.title)
end



#   Scenario: create game and genres with valid data

When /^I fill in the fields of game and genres with valid details and submit it$/ do


  @new_game_title="Mario"
  @new_game_description= "awesome"
  @new_genre_name="Jump and Run"


  fill_in("game_title", :with => @new_game_title)
  fill_in("game_description", :with => @new_game_description)
  fill_in("new_genres", :with => @new_genre_name)
  #select('genre1', :from => "game_genre_ids")
  click_button "Create Game"

end


Then /^I should see the details of the newly created game$/ do
  page.should have_content(@new_game_title)
  page.should have_content(@new_game_description)
  page.should have_content(@new_genre_name)

end



#   Scenario: fail to create game with empty name

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

When /^I follow the game edit link$/ do
  within(".game") do
    click_link_or_button "Edit"
  end
end

When /^I change the game's data and submit it$/ do

  @update_game_title="newGameTitle"
  @update_game_description= "newGameDesc"
  @givenGenre=FactoryGirl.create :genre , name:"Jump and Run and Hit"


  fill_in("game_title", :with => @update_game_title)
  fill_in("game_description", :with =>  @update_game_description)
  fill_in("new_genres", :with => @givenGenre.name)
  #select('genre3', :from => "game_genre_ids")
  click_button "Update Game"
end
Then /^I should be on the detail page of the given game$/ do
  current_path.should == game_path(@givenGame)
end
Then /^I should see the updated game content$/ do
  page.should have_content(@update_game_title)
  page.should have_content(@update_game_description)
  page.should have_content(@givenGenre.name)
  #select('genre3', :from => "game_genre_ids")
end




