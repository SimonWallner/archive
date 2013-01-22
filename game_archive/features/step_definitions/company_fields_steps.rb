When /^I enter valid company data$/ do
  @fieldCompany=FactoryGirl.create :company , name:"field Company"
  fill_in "company_name", :with => @fieldCompany.name
  sleep(1)
end
When /^I enter company field with "(.*?)"$/ do |fill|
  
    @day = "21"
    @month = "3"
    @year = "2012"
    @additionalDefunct = "additionalDefunct"
      sleep(1)
      if fill == "Founded"
        select(@day, :from => 'day_founded')
        select(@month, :from => 'month_founded')
        fill_in "year_founded", :with => @year
      end

      if fill == "Defunct"
        click_link_or_button "Add Field"
        select(fill, :from => 'newFieldId')
        select(@day, :from => 'day_defunct')
        select(@month, :from => 'month_defunct')
        fill_in "year_defunct", :with => @year
        fill_in "text_defunct", :with => @additionalDefunct
      end

      if fill == "External Links"
        @externalLinks= "new external links"
        fill_in "new_external_links", :with => @externalLinks
      end
      if fill == "Userdefined"
        @nameUserdefined = "new name Userdefined"
        @contentUserdefined = "new contentUserdefined"
        click_link_or_button "Add Field"
        select(fill, :from => 'newFieldId')
        fill_in "name_userdefined2", :with => @nameUserdefined
        fill_in "content_userdefined2", :with => @contentUserdefined
      end
      if fill == "Official Name"
        @textOfficialName = "new o name"
        fill_in "official_name", :with => @textOfficialName
      end
      if fill == "Location"
        @textLocation = "new Location"
        fill_in "new_locations", :with => @textLocation
      end
end

Then /^I create the company$/ do
  click_link_or_button "Create Company"
end

 
