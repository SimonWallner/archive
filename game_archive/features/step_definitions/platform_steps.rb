Given /^I have platforms named (.+)$/ do |names|
  @platforms = Array.new
  names.split(', ').each do |t|
    FactoryGirl.create :platform, name: t
    @platforms << t
  end
end

Given /^I have a platform named (.+)$/ do |name|
  @platform = FactoryGirl.create :platform, name: name
end

When /^I update the platform$/ do
  @newName = @platform.name + "new"
  fill_in("platform_name", :with => @newName)
  click_link_or_button "Update Platform"
end

Then /^I should see the new values of Platform$/ do
  page.should have_content(@newName)
end

Then /^I should see "(.+)" in the list of platforms$/ do |platforms|
    platforms.split(', ').each do |platform|
       page.should have_content(platform)
    end
end

Then /^I should see the platforms$/ do
  @platforms.each do |g|
    page.should have_content(g)
  end
end

When /^I create a valid platform$/ do
  name = "Platform1"
  fill_in("platform_name", :with => name)
  click_link_or_button "Create Platform"

  @platform = Platform.find_by_name name
end

Then /^I should see the created platform$/ do
  page.should have_content(@platform.name)
end

When /^I write the platform named (.+)$/ do |name|
  fill_in("new_platforms", :with => name)
end

Then /^I should not see the old platform$/ do
    page.should_not have_content(@platform)
end
