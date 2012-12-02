When /^I enter valid game data$/ do
  @game_title = "Game1"
  fill_in "game_title", :with => @game_title
end

When /^I enter a developer field with a developer$/ do
  fill_in "new_developers", :with => "dev:#{@givenDeveloper.id}:dev"
  click_link_or_button "Create Game"
end

Then /^The data should be saved$/ do
  g = Game.find_by_title @game_title
  g.should_not == nil
  g.mixed_fields.should_not == nil
  g.mixed_fields.size.should == 1
end

Then /^I should see the developer field$/ do
  page.should have_content(@givenDeveloper.name)
end

