#    Scenario: show developer's page
Given /^I have a developer (.+)$/ do |dev_name|
  @givenDeveloper=FactoryGirl.create :developer , name:dev_name
end
Given /^I am on the developers overview page$/ do
  visit developers_path
end
Then /^I should see the developers name in the list of developers$/ do
  page.should have_content(@givenDeveloper.name)
end

#    Scenario: create developer with valid data
When /^I follow the new developer link$/ do
  click_link_or_button "New Developer"
end
When /^I fill in the fields with valid details and submit it$/ do

  @devHans=FactoryGirl.create :developer , name:"Hans", description:"great programmer"

  fill_in("developer_name", :with => @devHans.name)
  fill_in("developer_description", :with => @devHans.description)
  click_button "Create Developer"

end

Then /^I should see the details of the newly created developer$/ do
  page.should have_content(@devHans.name)
  page.should have_content(@devHans.description)
end


#    Scenario: fail to create developer with empty name
Given /^I am on the developer creation page$/ do
  visit new_developer_path
end
When /^I leave the name field empty and submit it$/ do
  fill_in("developer_name", :with => "")
  fill_in("developer_description", :with => "")
  click_button "Create Developer"
end
Then /^I should be notified of that the name must not be empty$/ do
  page.should have_content("Name can't be blank")
end



#    Scenario: update developer's page with valid data

Given /^I am on the detail page of the given developer$/ do
  visit developer_path(@givenDeveloper)
end
And /^I follow the edit link$/ do
  within(".developer") do
    click_link_or_button "Edit"
  end
end
When /^I change the developer's data and submit it$/ do
  @givenDeveloper.name = "Bert"
  @givenDeveloper.description = "not so great programmer"

  fill_in("developer_name", :with => @givenDeveloper.name)
  fill_in("developer_description", :with => @givenDeveloper.description)
  click_button "Update Developer"

end


Then /^I should be on the detail page of the given developer$/ do
  current_path.should == developer_path(@givenDeveloper)
end


Then /^I should see the updated content$/ do
  page.should have_content(@givenDeveloper.name)
  page.should have_content(@givenDeveloper.description)
end











