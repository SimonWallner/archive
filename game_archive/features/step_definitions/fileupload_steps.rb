
When /^I fill in the fields with valid details for a (.+)$/ do |type|
  if type == "developer"
    @new_name ="Hans"
    fill_in("developer_name", :with => @new_name)
  elsif type == "game"
    @new_game = "newgame"
    fill_in("game_title", :with => @new_game)
  elsif type == "company"
    @new_company = "BowseruCo"
    fill_in("company_name", :with => @new_company)
  end

end

When /^I choose a valid file for a (.+)$/ do |type|

  if type == "developer"

    filename = "Luigi.png"
    tag = 'developer_image'

  elsif type == "game"

    filename = "diablo3.jpeg"
    tag = 'game_image'

  elsif type == "company"

    filename = "bowser.jpg"
    tag = 'company_image'

  end

  path = "#{Rails.root}/features/testpics/#{filename}"
  attach_file(tag,path)



end


Then /^I should see the picture on the details page of the (.+)$/ do |type|


  if type == "developer"

    if @new_name == nil
      @new_name = @givenDeveloper.name
    end

    id =   Developer.find_by_name(@new_name).id.to_s
   version = "tiled_4x"
    upload_to_path = "uploads/developer/image/" + id + "/Luigi.png"

  elsif type == "game"

    if @new_game == nil
      @new_game = @givenGame.title
    end

    id =   Game.find_by_title(@new_game).id.to_s
    version = "top_game"
    upload_to_path = "uploads/game/image/" + id + "/" + version + "_diablo3.jpeg"


  elsif type == "company"

    if @new_company == nil
      @new_company =  @givenCompany.name
    end
    id =   Company.find_by_name(@new_company).id.to_s
    version = "tiled_4x"
    upload_to_path = "uploads/company/image/" + id + "/bowser.jpg"


  end


  puts upload_to_path

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

  path = "#{Rails.root}/features/testpics/barley_too_big.jpg"
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
  page.should have_content("Image is too big")
end

Then /^I should be notified on that the file is not an image file$/ do
  page.should have_content("You are not allowed to upload")
end
