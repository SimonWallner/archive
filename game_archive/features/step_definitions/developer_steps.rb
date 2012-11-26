#    Scenario: show developer's page
Given /^I have a developer (.+)$/ do |dev_name|
  @givenDeveloper=FactoryGirl.create :developer , name:dev_name
end

Then /^I should see the developers name in the list of developers$/ do
  page.should have_content(@givenDeveloper.name)
end

#    Scenario: create developer with valid data

When /^I fill in the fields for the developer with valid details and submit it$/ do

  @new_name="Hans"
  @new_description = "great programmer"

  fill_in("developer_name", :with => @new_name)
  fill_in("developer_description", :with => @new_description)
  click_button "Create Developer"

end

Then /^I should see the details of the newly created developer$/ do
  page.should have_content(@new_name)
  page.should have_content(@new_description)
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

When /^I follow the developer edit link$/ do
  within(".developer") do
    click_link_or_button "Edit"
  end
end

When /^I set the name field empty and submit it$/ do
  fill_in("developer_name", :with => "")
  fill_in("developer_description", :with => "")
  click_button "Update Developer"
end

When /^I change the developer's data and submit it$/ do

  @update_name = "Bert"
  @update_description = "not so great programmer"

  fill_in("developer_name", :with => @update_name)
  fill_in("developer_description", :with => @update_description)
  click_button "Update Developer"

end


Then /^I should be on the detail page of the given developer$/ do
  current_path.should == developer_path(@givenDeveloper)
end


Then /^I should see the updated content$/ do
  page.should have_content(@update_name)
  page.should have_content(@update_description)
end











