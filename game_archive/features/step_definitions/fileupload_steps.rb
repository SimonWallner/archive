

When /^I choose a valid file for a (.+)$/ do |type|

  tag, path = get_path_and_tag_to_type(type)

  attach_file(tag,path)



end


Then /^I should see the picture on the details page of the (.+)$/ do |type|


  if type == "developer"

    if @new_name == nil
      @new_name = @givenDeveloper.name
    end

    #id =   Developer.find_by_name(@new_name).id.to_s
    id = (DeveloperVersioner.instance.current_version Developer.find_by_name(@new_name)).id.to_s

   version = "tiled_4x"
    upload_to_path = "uploads/developer/image/" + id + "/loudspeaker.png"

  elsif type == "game"

    if @new_game == nil
      @new_game = @givenGame.title
    end

    #id =   Game.find_by_title(@new_game).id.to_s
    id = (GameVersioner.instance.current_version Game.find_by_title(@new_game)).id.to_s
    version = "top_game"
    upload_to_path = "uploads/game/image/" + id + "/" + version + "_field.jpg"


  elsif type == "company"


    if @new_company == nil
      @new_company =  @givenCompany.name
    end

    #id =   Company.find_by_name(@new_company).id.to_s
    id = (CompanyVersioner.instance.current_version Company.find_by_name(@new_company)).id.to_s
    version = "tiled_4x"
    upload_to_path = "uploads/company/image/" + id + "/parliament.jpg"


  end

  page.should have_selector("img[src$='#{upload_to_path}']")


end

When /^I choose a file that is too big for a (.+)$/ do  |type|

  if type == "developer"

    tag = 'developer_image'


  elsif type == "game"

    tag = 'game_image'


  elsif type == "company"

    tag = 'company_image'


  end

  path = "#{Rails.root}/features/testpics/coin_big.jpg"
  attach_file(tag,path)

end

When /^I choose a filetype that it not allowed for a (.+)$/ do  |type|
  if type == "developer"

    tag = 'developer_image'


  elsif type == "game"

    tag = 'game_image'


  elsif type == "company"

    tag = 'company_image'


  end

  path = "#{Rails.root}/features/testpics/notallowed.rb"
  attach_file(tag,path)

end


Then /^I should be notified on that the Image is too big$/ do
  sleep(0.2)
  page.should have_content("is too big")
end

Then /^I should be notified on that the file is not an image file$/ do
  page.should have_content("You are not allowed to upload")
end
