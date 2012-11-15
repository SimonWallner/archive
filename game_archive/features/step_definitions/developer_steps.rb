#    Scenario: show developer's page
Given /^I have a developer Leela$/ do
  FactoryGirl.create :developer , name:"Leela"
end
Given /^I am on the developer's page$/ do
  visit "/#{"developers"}"
end
Then /^I should see their details$/ do
  page.should have_content(@name)
end



#    Scenario: create developer with valid data
Given /^I am on the devlopers overview page$/ do
  visit "/#{"developers"}"
end
When /^I follow the new developer link$/ do
  click_link_or_button "New Developer"
end
When /^I fill in the fields with valid details and submit it$/ do
  fill_in("developer_name", :with => "Hans")
  fill_in("developer_description", :with => "New Developer: Hans")
  click_button "Create Developer"
end
Then /^The devloper should have been created$/ do
  page.should have_content("Developer was successfully created.")
end
Then /^I should on the developer's page$/ do
  page.should have_content("Hans")
end


#    Scenario: fail to create developer with empty name
Given /^I am on the developer creation page$/ do
  visit "/developers/#{"new"} "
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
Given /^I have a developer Lori/ do
  FactoryGirl.create :developer, name: "Lori"
end
Given /^I am on her developer's page$/ do
  @develop = Developer.find_by_name "Lori"
  visit "/developers/#{@develop.id}"
end
And /^I follow the edit link$/ do
  click_link_or_button "Edit"
  visit "/developers/#{@develop.id}/#{"edit"}"
end
When /^I change the devloper's data and submit it$/ do
  fill_in("developer_name", :with => "DevName")
  fill_in("developer_description", :with => "DevDesc")
  click_button "Update Developer"
end
Then /^I should be on the devloper's page$/ do
  visit "/developers/#{@develop.id}"
end
Then /^I should see the updated content$/ do
  page.has_xpath?('.//p[@id="notice"]', :text => 'Developer was successfully updated.')
  page.should have_content("DevName")
  page.should have_content("DevDesc")
end









