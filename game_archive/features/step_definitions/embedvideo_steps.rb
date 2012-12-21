When /^I fill in (?:the|another) video field with (.*) embed code$/ do |type|

    @embedcode = get_embedcode_for_type(type)
    add_embedcode(@embedcode)

end

Then /^I should see the embedded (.*) video on the details page of the game$/ do |type|

    sleep(1)
    page.should have_css("iframe[name=\"#{type}\"]")

end

Then /^I should see the (\d+) embedded videos on the details page of the game$/ do |videocount|

  check_video_count(videocount)

end

Then /^I should not see an embedded video$/ do
  page.should_not have_css("iframe[name=\"youtube\"]") or have_css("iframe[name=\"vimeo\"]")
end

