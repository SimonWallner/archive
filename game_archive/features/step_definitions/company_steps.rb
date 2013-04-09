#		 Scenario: show company's page
Given /^I have a company (.+)$/ do |name|
	@givenCompany = FactoryGirl.create :company , name: name
end

Given /^I am on the company article page of (.+)$/ do |name|
	@givenCompany = FactoryGirl.create :company , name: name
	visit company_path(@givenCompany)
end

Then /^I should see the company's name in the list of companies$/ do
	page.should have_content(@givenCompany.name)
end

When /^I fill in the fields for the company with valid details and submit it$/ do
	@name="Awesome Corp zkWaXNGV98mZbqf9KXDD"
	@description = "awesome corp is awesome 0DtkS53PCSQ7nXBK34lX"

	fill_in("company_name", :with => @name)
	fill_in("company_description", :with => @description)
	click_button "Create Studio/Organisation Article"
end

Then /^I should see the details of the newly created company$/ do
	page.should have_content(@name)
	page.should have_content(@description)
end

When /^I leave the name of the company empty and submit it$/ do
	fill_in("company_name", :with => "")
	fill_in("company_description", :with => "")
	click_button "Create Studio/Organisation Article"
end

Then /^I should be notified that the name of company must not be empty$/ do
	page.should have_content("Name can't be blank")
end

When /^I set the name of company field empty and submit it$/ do
	fill_in("company_name", :with => "")
	fill_in("company_description", :with => "")
	click_button "Update Studio/Organisation Article"
end

When /^I change the company's data and submit it$/ do
	@update_name = "Blizzard"
	@update_description = "not so great firma"

	fill_in("company_name", :with => @update_name)
	fill_in("company_description", :with => @update_description)
	click_button "Update Studio/Organisation Article"
end

Given /^I follow the company edit link$/ do
	within(".company") do
		click_link_or_button "Edit"
	end
end

When /^I visit the company article page$/ do
	visit company_path(@givenCompany)
end

Then /^I should be on the company article page$/ do
	if (@givenCompany)
		URI.parse(current_url).path.should eql company_path(@givenCompany)
	else
		company = Company.find_by_name(@name)
		URI.parse(current_url).path.should eql company_path(company)
	end
end








