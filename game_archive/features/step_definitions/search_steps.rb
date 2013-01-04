Given /^I am on the Search Page$/ do
	visit('/search/query')
end

When /^I enter Tetris$/ do
	fill_in("query", :with => "Tetris")
end

When /^I enter Apple$/ do
	fill_in("query", :with => "Apple")
end

When /^I click the Search button$/ do
	click_button "Search"
end

Then /^I should have the game in the search results$/ do
	page.should have_content("Tetris")
end

Then /^I should have all three in the search results$/ do
	page.should have_content("Tetris")
	page.should have_content("Games")
	page.should have_content("Developers")
	page.should have_content("Companies")
end

Then /^I should have no search results$/ do
	page.should have_content("no results found!")
end