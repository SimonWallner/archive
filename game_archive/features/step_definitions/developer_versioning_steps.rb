Given /^I have a certain version number for the given developer$/ do


  fetched_developer = Developer.find_by_name @givenDeveloper.name

  curr_dev = DeveloperVersioner.instance.current_version @givenDeveloper

  @versionnumber = curr_dev.version_number

  puts @versionnumber


end


Then /^I should have the next version for the given developer$/ do


  fetched_developer = Developer.find_by_name @givenDeveloper.name

  curr_dev = DeveloperVersioner.instance.current_version @givenDeveloper
  curr_dev.version_number.to_s.should eq (@versionnumber+1).to_s

  puts @versionnumber+1


end

Then /^I should see the link for the next version in the list of versions$/ do

  within(:css, "#versions") do
    page.should have_link((@versionnumber+1).to_s)
    #page.should have_link(versionnumber.to_s, {:href => '/developers/10?version=2'})
  end

end


Given /^I have two different versions with different data for the developer (.+)$/ do |name|

  #create two new versions with different description

  @developer_old =  FactoryGirl.create :developer , name:"#{name}" , description:"testdescription_old", version_number:1 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"
  @developer_new =  FactoryGirl.create :developer , name:"#{name}" , description:"testdescription_new", version_number:2 , version_id: "276277ee-0490-4cd5-ae48-9b2152b632f9"

  @givenDeveloper = @developer_new

end

When /^I follow the link to the previous version$/ do
  within(:css, "#versions") do
    click_link @developer_old.version_number.to_s
    #page.should have_link(versionnumber.to_s, {:href => '/developers/10?version=2'})
  end
end

Then /^I should see different data$/ do
   @developer_old.description.should_not eq @developer_new.description
end



