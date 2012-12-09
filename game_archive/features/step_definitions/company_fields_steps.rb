Given /^I am on the company fields creation page$/ do
  visit new_company_path
  @fieldCompany=FactoryGirl.create :company , name:"field Company"
  fill_in "company_name", :with => @fieldCompany.name
  click_link_or_button "Add Field"
end

When /^I enter company field with "(.*?)"$/ do |fill|
  
    @day = "21"
    @month = "3"
    @year = "2012"
    @additionalDefunct = "additionalDefunct"
    within(".newFieldsDiv .addedField") do 
    
      if fill == "Founded"
      select(fill, :from => 'newFieldId')   
      select(@day, :from => 'day_founded')
      select(@month, :from => 'month_founded')
      fill_in "year_founded", :with => @year 
      sleep(1) 
    end
    
      if fill == "Defunct"
      select(fill, :from => 'newFieldId')   
      select(@day, :from => 'day_defunct')
      select(@month, :from => 'month_defunct')
      fill_in "year_defunct", :with => @year 
      fill_in "text_defunct", :with => @additionalDefunct 
      sleep(1) 
    end      
   
    if fill == "External Links"
      @externalLinks= "new external links"
      select(fill, :from => 'newFieldId')
      fill_in "new_external_links", :with => @externalLinks
      sleep(1) end
    if fill == "Userdefined"
      @nameUserdefined = "new name Userdefined"
      @contentUserdefined = "new contentUserdefined"
      select(fill, :from => 'newFieldId')
      fill_in "name_userdefined2", :with => @nameUserdefined
      fill_in "content_userdefined2", :with => @contentUserdefined
      sleep(1)end
    if fill == "Official Name"
      @textOfficialName = "new o name"
      select(fill, :from => 'newFieldId')
      fill_in "official_name", :with => @textOfficialName
      sleep(1) end
    if fill == "Location"
      @textLocation = "new Location"
      select(fill, :from => 'newFieldId')
      fill_in "new_locations", :with => @textLocation
      sleep(1) end
  end

end

Then /^should create company$/ do
  click_link_or_button "Create Company"
end

When /^The data of company be saved$/ do
  Company.count.should eq 2
end

 
