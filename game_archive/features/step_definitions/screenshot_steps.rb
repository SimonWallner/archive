When /^I choose (?:a|an|another) (.*) screenshot for a game$/ do |type|

  if type == "valid"

    filename1 = "diablo3.jpeg"
    filename2 = "halo4.jpg"
    filename3 = "Luigi.png"

    filename_array = [filename1,filename2,filename3]

    @filename = filename_array.sample

  elsif type == "invalid"
    @filename = "notallowed.rb"
  elsif type == "big"
    @filename = "marioverybig.jpg"
  else
    @filename = ""
  end

  attach_screenshot(@filename)

end

Then /^I should (.*) the screenshot on the details page of the game$/ do |type|

  check_for_screenshot(@filename, @new_game, type)

end


Then /^I should see the (\d+) screenshots on the details page of the game$/ do |screenshotcount|

  check_screenshot_count(screenshotcount)

end

When /^I remove the screenshot$/ do
  remove_screenshot
end





