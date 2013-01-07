  When /^I enter valid developer data$/ do
   @fieldDeveloper=FactoryGirl.create :developer , name:"field Developer"
   fill_in "developer_name", :with => @fieldDeveloper.name
   sleep(1)
 end
When /^I enter developer field with "(.*?)"$/ do |fill|   

    if fill == "External Links"
      @externalLinks= "new external links"
      fill_in "new_external_links", :with => @externalLinks
    end
    if fill == "Userdefined"
      @nameUserdefined = "new name Userdefined"
      @contentUserdefined = "new contentUserdefined"
      click_link_or_button "Add Field"
      select(fill, :from => 'newFieldId')
      fill_in "name_userdefined1", :with => @nameUserdefined
      fill_in "content_userdefined1", :with => @contentUserdefined
    end
end

Then /^I create the developer$/ do
click_link_or_button "Create Developer"
end

 