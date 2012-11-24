#    Scenario: show company's page
Given /^I have a company (.+)$/ do |com_name|
  @givenCompany=FactoryGirl.create :company , name:com_name
end

Then /^I should see the companies name in the list of companies$/ do
  page.should have_content(@givenCompany.name)
end

#    Scenario: create company with valid data

When /^I fill in the fields for the company with valid details and submit it$/ do

  @new_name="Blizzard"
  @new_description = "great firma"

  fill_in("company_name", :with => @new_name)
  fill_in("company_description", :with => @new_description)
  click_button "Create Company"

end

Then /^I should see the details of the newly created company$/ do
  page.should have_content(@new_name)
  page.should have_content(@new_description)
end


#    Scenario: fail to create company with empty name
Given /^I am on the company creation page$/ do
  visit new_company_path
end
When /^I leave the name of company field empty and submit it$/ do
  fill_in("company_name", :with => "")
  fill_in("company_description", :with => "")
  click_button "Create Company"
end

Then /^I should be notified of that the name of company must not be empty$/ do
  page.should have_content("Name can't be blank")
end



#    Scenario: update company's page with valid data

Given /^I am on the detail page of the given company$/ do
  visit company_path(@givenCompany)
end

When /^I change the company's data and submit it$/ do

  @update_name = "Blizzard"
  @update_description = "not so great firma"

  fill_in("company_name", :with => @update_name)
  fill_in("company_description", :with => @update_description)
  click_button "Update Company"

end


Then /^I should be on the detail page of the given company$/ do
  current_path.should == company_path(@givenCompany)
end

Given /^I follow the company edit link$/ do
  within(".company") do
    click_link_or_button "Edit"
  end
end











