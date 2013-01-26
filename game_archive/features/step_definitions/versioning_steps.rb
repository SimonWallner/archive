Given /^I have a certain version number for the given (.+)$/ do |type|


  if type == "developer"

    @versionnumber =  (DeveloperVersioner.instance.current_version @givenDeveloper).version_number

    puts @versionnumber

  elsif type == "company"
    @versionnumber = (CompanyVersioner.instance.current_version @givenCompany).version_number
    puts @versionnumber
  end



end


Then /^I should have the next version for the given (.+)$/ do |type|

  if type == "developer"


    curr_dev = DeveloperVersioner.instance.current_version @givenDeveloper
    curr_dev.version_number.to_s.should eq (@versionnumber+1).to_s

    puts @versionnumber+1


  elsif type == "company"
    curr_com = CompanyVersioner.instance.current_version @givenCompany
    curr_com.version_number.to_s.should eq (@versionnumber+1).to_s

    puts @versionnumber+1

  end




end

Then /^I should see the link for the next version in the list of versions$/ do

  within(:css, "#versions") do
    page.should have_link((@versionnumber+1).to_s)
    #page.should have_link(versionnumber.to_s, {:href => '/developers/10?version=2'})
  end

end


Given /^I have two different versions with different data for a (.+)$/ do |type|


  #visit creation page, then fill out all the fields of the form, submit it, change the data and submit again
  if type == "developer"

      visit_developer_creation_page

      @old_name="Hans"
      @old_description = "great programmer"
      @old_filename = "loudspeaker.png"
      @old_external_link_name =  "WikipediaExternalLink"
      @old_external_link= "[#{@old_external_link_name}](http://wikipedia.org)"


      fill_in("developer_name", :with => @old_name)
      fill_in("developer_description", :with => @old_description)

      path = "#{Rails.root}/features/testpics/#{@old_filename}"
      tag = 'developer_image'
      attach_file(tag,path)


      fill_in "new_external_links", :with => @old_external_link

      submit_any_button


      @developer_old = DeveloperVersioner.instance.current_version Developer.find_by_name @old_name

      click_link "Edit"


      @new_description = "great programmer_new"
      @new_filename = "field.jpg"
      @new_external_link_name= "GoogleExternalLink"
      @new_external_link= "[#{@new_external_link_name}](http://google.com)"


      fill_in("developer_name", :with => @old_name)
      fill_in("developer_description", :with => @new_description)

      path = "#{Rails.root}/features/testpics/#{@new_filename}"
      tag = 'developer_image'
      attach_file(tag,path)


      fill_in "new_external_links", :with => @new_external_link

      submit_any_button

      @developer_new = DeveloperVersioner.instance.current_version Developer.find_by_name @old_name

      @givenDeveloper = @developer_new


  #visit creation page, then fill out all the fields of the form, submit it, change the data and submit again
  elsif type == "company"


      visit_company_creation_page

      @old_name="Peterson"
      @old_description = "great company"
      @old_filename = "loudspeaker.png"
      @old_external_link_name =  "WikipediaExternalLink"
      @old_external_link= "[#{@old_external_link_name}](http://wikipedia.org)"
      @old_official_name = "Peterson Co"
      @old_locations = "California"

      @old_day = "1"
      @old_month = "3"
      @old_year = "2012"


      fill_in("company_name", :with => @old_name)
      fill_in("company_description", :with => @old_description)

      path = "#{Rails.root}/features/testpics/#{@old_filename}"
      tag = 'company_image'
      attach_file(tag,path)

      fill_in "new_external_links", :with => @old_external_link

      select(@old_day, :from => 'day_founded')
      select(@old_month, :from => 'month_founded')
      fill_in "year_founded", :with => @old_year

      fill_in "official_name", :with => @old_official_name
      fill_in "new_locations", :with => @old_locations

      submit_any_button


      @company_old = CompanyVersioner.instance.current_version Company.find_by_name @old_name

      click_link "Edit"


      @new_description = "great company_new"
      @new_filename = "field.jpg"
      @new_external_link_name= "GoogleExternalLink"
      @new_external_link= "[#{@new_external_link_name}](http://google.com)"
      @new_official_name = "Peterson Co_new"
      @new_locations = "Florida"
      @new_day = "2"
      @new_month = "4"
      @new_year = "2011"


      fill_in("company_name", :with => @old_name)
      fill_in("company_description", :with => @new_description)

      path = "#{Rails.root}/features/testpics/#{@new_filename}"
      tag = 'company_image'
      attach_file(tag,path)

      fill_in "new_external_links", :with => @new_external_link

      select(@new_day, :from => 'day_founded')
      select(@new_month, :from => 'month_founded')
      fill_in "year_founded", :with => @new_year

      fill_in "official_name", :with => @new_official_name
      fill_in "new_locations", :with => @new_locations

      submit_any_button

      @company_new = CompanyVersioner.instance.current_version Company.find_by_name @old_name

      @givenCompany = @company_new

  end

end

When /^I follow the link to the previous version of the (.+)$/ do |type|


  if type == "developer"

    within(:css, "#versions") do
      click_link  @developer_old.version_number.to_s
    end

  elsif type == "company"

    within(:css, "#versions") do
      click_link  @company_old.version_number.to_s
    end
  end


end

Then /^I should see different data for the old version of the (.+)$/ do |type|

  page.should_not have_content @new_description
  page.should have_content @old_description

  page.should_not have_link @new_external_link_name
  page.should have_link @old_external_link_name

  if type == "developer"

    id = (DeveloperVersioner.instance.current_version Developer.find_by_name(@old_name)).id.to_s

  elsif type == "company"

    id = (CompanyVersioner.instance.current_version Company.find_by_name(@old_name)).id.to_s

    page.should_not have_content @new_official_name
    page.should have_content @old_official_name

    page.should_not have_content (@new_day +"." +@new_month+"." + @new_year)
    page.should have_content (@old_day +"." +@old_month+"." + @old_year)

  end

  upload_to_path = "uploads/"+ type +"/image/" + id + "/" +@new_filename
  page.should_not have_selector("img[src$='#{upload_to_path}']")

  upload_to_path = "uploads/"+ type +"/image/" + ((id.to_i-1).to_s) + "/" + @old_filename
  page.should have_selector("img[src$='/#{upload_to_path}']")



end



