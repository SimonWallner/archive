module GamesHelper

  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    return %Q{<iframe name="youtube" width="688" height="349" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end

  def vimeo_embed(vimeo_url)
    #extract id from url

    if vimeo_url[/player\.vimeo\.com\/video\/([0-9]*)/]
      vimeo_id = $1
    end

   return %Q{<iframe name="vimeo" src="http://player.vimeo.com/video/#{vimeo_id}" width="688" height="349"  webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe> }

  end

  def embed_video(url)

    if (url [/youtu\.be\/([^\?]*)/]) or (url [/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/])
      youtube_embed(url)
    elsif url[/player\.vimeo\.com\/video\/([0-9]*)/]
      vimeo_embed(url)

    end

  end

  def link_to_remove_video_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_video_fields(this)")
  end


  def link_to_add_video_fields(name, f, association)
    new_object = Video.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :builder => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end



  def link_to_remove_screenshot_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_screenshot_fields(this)")
  end

  def link_to_add_screenshot_fields(name, f, association)
    new_object = Screenshot.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :builder => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

end
