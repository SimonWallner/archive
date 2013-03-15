require 'SecureRandom'

#		Scenario: show game's page
Given /^I have a game (.*)$/ do |game_name|
	@givenGame = FactoryGirl.create :game, title: game_name
end

Given /^I am on the game article page of (.*)$/ do |game_name|
	@givenGame = FactoryGirl.create :game, title: game_name
	visit game_path(@givenGame)
end

Given /^I have (\d+) versions of the game (.*)$/ do |count, game_name|
	@givenGames = Array.new
	for i in 1..count.to_i
		@givenGames.push(FactoryGirl.create :game, title: game_name + " some randomness: #{SecureRandom.uuid.to_s}", version_id: "someVersionID", version_number: i)
	end 
	@givenGame = @givenGames[0]
end

When /^I visit the game article with an id from an older version$/ do
	visit game_path(@givenGames[1])
end

Then /^I should see the current version of the game$/ do
	page.should have_content(@givenGames.last.title)
end

When /^I visit the game page for a specific version$/ do
	@specific_version = @givenGames[@givenGames.length/2.floor]
	visit game_version_path(@specific_version.id, @specific_version.version_number)
end

Then /^I should see this version of the game article$/ do
	page.should have_content @specific_version.title
end

When /^I edit the game article$/ do
	visit edit_game_path(@givenGame)
	submit_any_button
end

Then /^I should be on the game article page showing the new version$/ do
	within '#current-version' do
  		page.should have_content @givenGame.version_number + 1
	end
end

Then /^I should be on the game article page showing the restored version$/ do
	URI.parse(current_url).path.should == game_path(@givenGames.last.id+1)
	page.should have_content @specific_version.title
end

When /^I visit the game article page$/ do
	visit game_path(@givenGame)
end

When /^I follow the link to another version$/ do
	within '#versions' do
		@specific_version = @givenGames[@givenGames.length/2.floor]
		click_link @specific_version.version_number.to_s
	end
end

Then /^I should see the current version number$/ do
	within '#current-version' do
		page.should have_content @givenGames.length
	end
end

Then /^I should see links to all available versions$/ do
	within '#versions' do
		@givenGames.each do |game|
	  		page.should have_link game.version_number.to_s
		end
	end
end

Then /^I should see a link to restore this version$/ do
	within '#versions' do
		page.should have_link "restore this version"
	end
end

When /^follow the restore link$/ do
	within '#versions' do
		click_link 'restore this version'
	end
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

#		Scenario: create game and genres with valid data

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

#		Scenario: fail to create game with empty name

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


#		Scenarios: update game's page

When /^I follow the game edit link$/ do
		click_link_or_button "Edit"
end

When /^I change the game's data and submit it$/ do

	@update_game_title="newGameTitle"
	@update_game_description= "newGameDesc"
	fill_in("game_title", :with => @update_game_title)
	fill_in("game_description", :with =>	@update_game_description) 
	click_button "Update Game"
end

Then /^I should see the updated game content$/ do
	page.should have_content(@update_game_title)
	page.should have_content(@update_game_description)
end

Then /^I should see a link to the reporting form$/ do
  page.should have_content("Report")
end

Then /^I should be on the report article page$/ do
	URI.parse(current_url).path.should eq(report_game_path(@givenGame))
end

