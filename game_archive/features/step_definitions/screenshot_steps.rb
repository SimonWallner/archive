When /^I choose (?:a|an|another) (.*) screenshot for a game$/ do |type|


  @filename = choose_filename_by_type(type)
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





