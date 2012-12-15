def attach_screenshot(filename)

  path = "#{Rails.root}/features/testpics/#{filename}"

  click_link_or_button('Add Screenshot')
  sleep(0.2)

  within(:css, "#screenshots") do
    allinputfields =  page.all(:css, "input")
    tag =  allinputfields[-2][:id]
    attach_file(tag,path)

  end

end

def remove_screenshot

  within(:css, "#screenshots") do
    click_link_or_button('remove')
    sleep(0.2)
  end

end


def check_for_screenshot(filename, new_game, type)

  id =   Game.find_by_title(@new_game).id.to_s
  upload_to_path = "uploads/screenshot/image/" + id + "/#{@filename}"

  if type == "see"
    page.should have_selector("img[src$='#{upload_to_path}']")
  elsif type == "not see"
    page.should_not have_selector("img[src$='#{upload_to_path}']")
  end

end

def check_screenshot_count(screenshotcount)
  sleep(0.5)
  foundcount = 0

  allscreenshots = page.all(:css, "img[src^=\"/uploads/screenshot/image\"]")
  foundcount = allscreenshots.count

  if screenshotcount.to_i != foundcount.to_i
    raise 'Not the right number of screenshots on the page!!!'
  end
end