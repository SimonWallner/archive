Given /^I have modes named (.+)$/ do |names|
  @modes = Array.new
  names.split(', ').each do |t|
    FactoryGirl.create :mode, name: t
    @modes << t
  end
end

Given /^I have a mode named (.+)$/ do |name|
  @mode = FactoryGirl.create :mode, name: name
end

When /^I update the mode$/ do
  @newName = @mode.name + "new"
  @newDesc = @mode.description + "new"
  fill_in("mode_name", :with => @newName)
  fill_in("mode_description", :with => @newDesc)
  click_link_or_button "Update Mode"
end

Then /^I should see the new values of Mode$/ do
  page.should have_content(@newName)
  page.should have_content(@newDesc)
end

Then /^I should see "(.+)" in the list of modes$/ do |modes|
    modes.split(', ').each do |mode|
       page.should have_content(mode)
    end
end

Then /^I should see the modes$/ do
  @modes.each do |g|
    page.should have_content(g)
  end
end

When /^I create a valid mode$/ do
  name = "Mode1"
  fill_in("mode_name", :with => name)
  fill_in("mode_description", :with => "Desc1")
  click_link_or_button "Create Mode"

  @mode = Mode.find_by_name name
end

Then /^I should see the created mode$/ do
  page.should have_content(@mode.name)
  page.should have_content(@mode.description)
end
