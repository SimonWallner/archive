When /^I choose (?:a|an|another) (.*) screenshot for a game$/ do |type|

  if type == "valid"

    filename1 = "diablo3.jpeg"
    filename2 = "halo4.jpg"
    filename3 = "Luigi.png"

    filename_array = [filename1,filename2,filename3]

    @filename = filename_array.sample
  elsif type == "invalid"
    @filename = "notallowed.rb"
  else
    @filename = ""
  end

  path = "#{Rails.root}/features/testpics/#{@filename}"

  click_link_or_button('Add Screenshot')
  sleep(0.2)

  within(:css, "#screenshots") do
    allinputfields =  page.all(:css, "input")
    tag =  allinputfields[-2][:id]
    attach_file(tag,path)

  end
end

Then /^I should see the screenshot on the details page of the game$/ do
  id =   Game.find_by_title(@new_game).id.to_s
  upload_to_path = "uploads/screenshot/image/" + id + "/#{@filename}"

  page.should have_selector("img[src$='#{upload_to_path}']")

end


Then /^I should see the (\d+) screenshots on the details page of the game$/ do |screenshotcount|

  sleep(0.5)
  foundcount = 0

  allscreenshots = page.all(:css, "img[src^=\"/uploads/screenshot/image\"]")
  foundcount = allscreenshots.count

  if screenshotcount.to_i != foundcount.to_i
    raise 'Not the right number of screenshots on the page!!!'
  end
end



