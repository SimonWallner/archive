Given /^I have a certain version number for the given (.+)$/ do |type|

  if type == "developer"
    @versionnumber =  (DeveloperVersioner.instance.current_version @givenDeveloper).version_number

  elsif type == "company"
    @versionnumber = (CompanyVersioner.instance.current_version @givenCompany).version_number

  elsif type == "game"
    @versionnumber = (GameVersioner.instance.current_version @givenGame).version_number
  end
end


Then /^I should have the next version for the given (.+)$/ do |type|

  if type == "developer"

    curr = DeveloperVersioner.instance.current_version @givenDeveloper

  elsif type == "company"
    curr = CompanyVersioner.instance.current_version @givenCompany

  elsif type == "game"
    curr = GameVersioner.instance.current_version @givenGame

  end
  curr.version_number.to_s.should eq (@versionnumber+1).to_s
end

Then /^I should see the link for the next version in the list of versions$/ do

  within(:css, "#versions") do
    page.should have_link((@versionnumber+1).to_s)
  end

end


Given /^I have two different versions with different data for a (.+)$/ do |type|


  #visit creation page, then fill out all the fields of the form, submit it, change the data and submit again
  if type == "developer"

      #visit creation page
      visit_developer_creation_page

      #fill in the fields
      fill_in_all_for_developer "old"

      #submit it
      submit_any_button

      @developer_old = DeveloperVersioner.instance.current_version Developer.find_by_name @old_name

      #edit the page
      click_link "Edit"

      #change the fields
      fill_in_all_for_developer "new"

      #submit again
      submit_any_button

      @developer_new = DeveloperVersioner.instance.current_version Developer.find_by_name @old_name

      @givenDeveloper = @developer_new


  #visit creation page, then fill out all the fields of the form, submit it, change the data and submit again
  elsif type == "company"

      visit_company_creation_page

      fill_in_all_for_company "old"

      submit_any_button

      @company_old = CompanyVersioner.instance.current_version Company.find_by_name @old_name

      click_link "Edit"


      fill_in_all_for_company "new"

      submit_any_button

      @company_new = CompanyVersioner.instance.current_version Company.find_by_name @old_name

      @givenCompany = @company_new

  elsif type == "game"


    visit_game_creation_page

    fill_in_all_for_game "old"

    submit_any_button

    @game_old = GameVersioner.instance.current_version Game.find_by_title @old_name

    click_link "Edit"

    fill_in_all_for_game "new"

    submit_any_button

    @game_new = GameVersioner.instance.current_version Game.find_by_title @old_name

    @givenGame = @game_new

  end

end

When /^I follow the link to the previous version of the (.+)$/ do |type|
    within(:css, "#versions") do

      if type == "developer"

          click_link  @developer_old.version_number.to_s

      elsif type == "company"

          click_link  @company_old.version_number.to_s
      elsif type == "game"

        click_link  @game_old.version_number.to_s
      end
  end


end

Then /^I should see data (?:for|from) the old version (?:of|in) the (.+)$/ do |type|

  page.should_not have_content @new_description
  page.should have_content @old_description

  page.should_not have_link @new_external_link_name
  page.should have_link @old_external_link_name

  if (type == "developer") or (type == "reverted developer")

    id = (DeveloperVersioner.instance.current_version Developer.find_by_name(@old_name)).id.to_s

    if type == "developer"

    upload_to_path = "uploads/developer/image/" + id + "/" + @new_filename
    page.should_not have_selector("img[src$='#{upload_to_path}']")

    upload_to_path_prev = "uploads/developer/image/" + ((id.to_i-1).to_s ) + "/" + @old_filename

    elsif type == "reverted developer"


      upload_to_path = "uploads/developer/image/" + (id.to_i-1).to_s+ "/" + @new_filename
      page.should_not have_selector("img[src$='#{upload_to_path}']")

      upload_to_path_prev = "uploads/developer/image/" + id.to_s + "/" + @old_filename

    end

    page.should have_selector("img[src$='/#{upload_to_path_prev}']")

  elsif (type == "company") or (type == "reverted company")

    id = (CompanyVersioner.instance.current_version Company.find_by_name(@old_name)).id.to_s

    page.should_not have_content @new_official_name
    page.should have_content @old_official_name

    page.should_not have_content (@new_day +"." +@new_month+"." + @new_year)
    page.should have_content (@old_day +"." +@old_month+"." + @old_year)

    if type == "company"

      upload_to_path = "uploads/company/image/" + id + "/" + @new_filename
      page.should_not have_selector("img[src$='#{upload_to_path}']")

      upload_to_path = "uploads/company/image/" + ((id.to_i-1).to_s) + "/" + @old_filename
      page.should have_selector("img[src$='/#{upload_to_path}']")

    elsif type == "reverted company"

      upload_to_path = "uploads/company/image/" + ((id.to_i-1).to_s ) + "/" + @new_filename
      page.should_not have_selector("img[src$='#{upload_to_path}']")

      upload_to_path = "uploads/company/image/" + id.to_s + "/" + @old_filename
      page.should have_selector("img[src$='/#{upload_to_path}']")

    end


  elsif type == "game"

    id = (GameVersioner.instance.current_version Game.find_by_title(@old_name)).id.to_s

    upload_to_path = "uploads/"+ type +"/image/" + id + "/top_game_" + @new_filename
    page.should_not have_selector("img[src$='#{upload_to_path}']")

    upload_to_path = "uploads/"+ type +"/image/" + ((id.to_i-1).to_s) + "/top_game_" + @old_filename
    page.should have_selector("img[src$='/#{upload_to_path}']")

    page.should_not have_content @new_developer
    page.should have_content @old_developer

    page.should_not have_content @new_publisher
    page.should have_content @old_publisher

    page.should_not have_content @new_distributor
    page.should have_content @old_distributor

    page.should_not have_content @new_credits
    page.should have_content @old_credits

    page.should_not have_content @new_series
    page.should have_content @old_series

    page.should have_content @old_platform
    page.should have_content @old_genres
    page.should have_content @old_tags
    page.should have_content @old_mode
    page.should have_content @old_media



  end
end


When /^I revert to the previous version$/ do
  click_link "make current version"
end

Then /^I should see a newly created version in the version links for a (.+)$/ do |type|
  within(:css, "#versions") do
    if type == "developer"

      page.should have_link((@developer_new.version_number+1).to_s)

    elsif type == "company"
      page.should have_link((@company_new.version_number+1).to_s)

    elsif type == "game"
      page.should have_link((@company_new.version_number+1).to_s)

    end
  end


end
