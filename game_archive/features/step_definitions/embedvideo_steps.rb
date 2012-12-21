When /^I fill in (?:the|another) video field with (.*) embed code$/ do |type|

    if type == "youtube"
      @embedcode = "http://youtu.be/YlUKcNNmywk"
    elsif type == "vimeo"
      @embedcode = %Q{"<iframe src="http://player.vimeo.com/video/51114870?badge=0" width="500" height="281" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe> <p><a href="http://vimeo.com/51114870">Halo4 InfinityTrailer</a> from <a href="http://vimeo.com/user8906415">MINHO</a> on <a href="http://vimeo.com">Vimeo</a>.</p>"}
    end

    click_link_or_button('Add Video')
    sleep(0.2)
    within(:css, "#videos") do
      alltextareas =  page.all(:css, "textarea")

      if type == "no"
        alltextareas.last.set ""
      elsif type == "wrong"
        alltextareas.last.set "bliblablub"
      else
        alltextareas.last.set @embedcode
      end

    end
end

Then /^I should see the embedded (.*) video on the details page of the game$/ do |type|

    sleep(1)
    page.should have_css("iframe[name=\"#{type}\"]")

end

Then /^I should see the (\d+) embedded videos on the details page of the game$/ do |videocount|


    sleep(2)
    foundcount = 0

    allyoutube = page.all(:css, "iframe[name=\"youtube\"]")
    foundcount = allyoutube.count
    allvimeo = page.all(:css, "iframe[name=\"vimeo\"]")
    foundcount += allvimeo.count

    #puts foundcount
    #puts videocount

    if videocount.to_i != foundcount.to_i
      raise 'Not the right number of videos on the page!!!'
    end

end


Then /^I should not see an embedded video$/ do
  page.should_not have_css("iframe[name=\"youtube\"]") or have_css("iframe[name=\"vimeo\"]")
end

