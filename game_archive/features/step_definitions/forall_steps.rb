
When /^I follow the new game link$/ do
  click_link_or_button "New Game"
end

When /^I follow the new developer link$/ do
  click_link_or_button "New Developer"
end

When /^I follow the new company link$/ do
  click_link_or_button "New Company"
end

When /^I follow the edit link$/ do
  click_link_or_button "Edit"
end


Given /^I am on the edit page of the given developer$/ do
  visit edit_developer_path(@givenDeveloper)
end

Given /^I am on the edit page of the given company$/ do
  visit edit_developer_path(@givenCompany)
end

Given /^I am on the edit page of the given game$/ do
  visit edit_game_path(@givenGame)
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


When /^I submit it$/ do

  begin
    if find_button("Update Developer")
      click_button "Update Developer"
      puts "Clicked Update Developer"
    end
  rescue Capybara::ElementNotFound
    puts "Update Developer not found"
  end
  
  begin
    if find_button("Create Developer")
      click_button "Create Developer"
      puts "Clicked Create Developer"
    end
  rescue Capybara::ElementNotFound
    puts "Create Developer not found"
  end
  
  begin
    if find_button("Create Game")
      click_button "Create Game"
      puts "Clicked Create Game"
    end
  rescue Capybara::ElementNotFound
    puts "Create Game not found"
  end
  begin
    if find_button("Update Game")
      click_button "Update Game"
      puts "Clicked Update Game"
    end
  rescue Capybara::ElementNotFound
    puts "Update Game not found"
  end
  begin
    if find_button("Update Company")
      click_button "Update Company"
      puts "Clicked Update Company"
    end
  rescue Capybara::ElementNotFound
    puts "Update Company not found"
  end
  begin
    if find_button("Create Company")
      click_button "Create Company"
      puts "Clicked Create Company"
    end
  rescue Capybara::ElementNotFound
    puts "Create Company not found"
  end



end