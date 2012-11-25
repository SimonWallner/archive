Given /^I have genres named (.+)$/ do |names|
  @genres = Array.new
  names.split(', ').each do |t|
    FactoryGirl.create :genre, name: t
    @genres << t
  end
end

Given /^I have a genre named (.+)$/ do |name|
  @genre = FactoryGirl.create :genre, name: name
end



When /^I update the genre$/ do
  @newName = @genre.name + "new"
  @newDesc = @genre.description + "new"
  fill_in("genre_name", :with => @newName)
  fill_in("genre_description", :with => @newDesc)
  click_link_or_button "Update Genre"
end

Then /^I should see the new values$/ do
  page.should have_content(@newName)
  page.should have_content(@newDesc)
end

Then /^I should see "(.+)" in the list of genres$/ do |genres|
    genres.split(', ').each do |genre|
       page.should have_content(genre)
    end
end



Then /^I should see the genres$/ do
  @genres.each do |g|
    page.should have_content(g)
  end
end

Given /^I am on the edit page of the genre$/ do
  visit "/genres/#{@genre.id}/edit"
end
When /^I create a valid genre$/ do
  name = "Genre1"
  fill_in("genre_name", :with => name)
  fill_in("genre_description", :with => "Desc1")
  click_link_or_button "Create Genre"

  @genre = Genre.find_by_name name
end

Then /^I should see the created genre$/ do
  page.should have_content(@genre.name)
  page.should have_content(@genre.description)
end
