Given /^I have media named (.+)$/ do |names|
  @media = Array.new
  names.split(', ').each do |t|
    FactoryGirl.create :medium, name: t
    @media << t
  end
end

Given /^I have a medium named (.+)$/ do |name|
  @medium = FactoryGirl.create :medium, name: name
end

When /^I update the medium$/ do
  @newName = @medium.name + "new"
  fill_in("medium_name", :with => @newName)
  click_link_or_button "Update Medium"
end

Then /^I should see the new values of Medium$/ do
  page.should have_content(@newName)
end

Then /^I should see "(.+)" in the list of media$/ do |media|
    media.split(', ').each do |medium|
       page.should have_content(medium)
    end
end

Then /^I should see the media$/ do
  @media.each do |g|
    page.should have_content(g)
  end
end

When /^I create a valid medium$/ do
  name = "Medium1"
  fill_in("medium_name", :with => name)
  click_link_or_button "Create Medium"

  @medium = Medium.find_by_name name
end

Then /^I should see the created medium$/ do
  page.should have_content(@medium.name)
end
