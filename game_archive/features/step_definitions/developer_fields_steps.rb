 
 Given /^I am on the developer fields creation page$/ do
   
  visit new_developer_path  
  @fieldDeveloper=FactoryGirl.create :developer , name:"field Developer"
  fill_in "developer_name", :with => @fieldDeveloper.name
  click_link_or_button "Add Field"

end 
     
     
When /^I enter developer field with "(.*?)"$/ do |fill|   
   
    within(".newFieldsDiv .addedField") do   
    if fill == "Credits"
      @textCredits = "new credits"
      select(fill, :from => 'newFieldId')
      fill_in "new_credits", :with => @textCredits
      sleep(1) end 

    if fill == "External Links"
      @externalLinks= "new external links"
      select(fill, :from => 'newFieldId')
      fill_in "new_external_links", :with => @externalLinks
      sleep(1)
    end
    if fill == "Userdefined"
      @nameUserdefined = "new name Userdefined"
      @contentUserdefined = "new contentUserdefined"
      select(fill, :from => 'newFieldId')
      fill_in "name_userdefined1", :with => @nameUserdefined
      fill_in "content_userdefined1", :with => @contentUserdefined
      sleep(1)
    end 
  end
  
  
  
end

Then /^should create developer$/ do
click_link_or_button "Create Developer"
end

When /^The data of developer be saved$/ do 
    Developer.count.should eq 2
end

 