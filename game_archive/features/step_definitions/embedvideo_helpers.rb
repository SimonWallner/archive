def get_embedcode_for_type(type)

  if type == "youtube"
    return "http://youtu.be/YlUKcNNmywk"
  elsif type == "vimeo"
    return %Q{"<iframe src="http://player.vimeo.com/video/51114870?badge=0" width="500" height="281" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe> <p><a href="http://vimeo.com/51114870">Halo4 InfinityTrailer</a> from <a href="http://vimeo.com/user8906415">MINHO</a> on <a href="http://vimeo.com">Vimeo</a>.</p>"}
  elsif type == "no"
    return ""
  elsif type == "wrong"
    return "bliblablub"
  else
    return nil
  end
end

def add_embedcode(embedcode)

  click_link_or_button('Add Video')
  sleep(0.2)
  within(:css, "#videos") do
    alltextareas =  page.all(:css, "textarea")
    alltextareas.last.set embedcode

  end

end

def check_video_count(videocount)

  sleep(1)
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