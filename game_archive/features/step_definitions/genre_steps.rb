Given /^I have genres named (.+)$/ do |names|
  names.split(', ').each do |t|
    FactoryGirl.create :genre, name: t
  end
end

Given /^I have a genre named "(.*?)"$/ do |name|
  FactoryGirl.create :genre, name: name
end

Then /^I can edit genre_name with value "(.*?)"$/ do |value|
  assert find_field("genre_name").value == value
end

Given /^I am on the (.+) genre_page of "(.*?)"$/ do |type, name|
  genre = Genre.find_by_name name
  visit "/genres/#{genre.id}/#{type}"
end


Then /^I should see "(.+)" in the list of genres$/ do |genres|
    genres.split(', ').each do |genre|
       page.should have_content(genre)
    end
end
