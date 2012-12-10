module GamesHelper

  def youtube_embed(youtube_id)
    return %Q{<iframe name="youtube" width="688" height="349" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end

  def vimeo_embed(vimeo_id)

   return %Q{<iframe name="vimeo" src="http://player.vimeo.com/video/#{vimeo_id}" width="688" height="349"  webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe> }

  end

  def embed_video(url)

    if url[/youtu\.be\/([^\?]*)/]
      youtube_embed($1)
    elsif url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_embed($5)
    elsif url[/player\.vimeo\.com\/video\/([0-9]*)/]
      vimeo_embed($1)
    elsif url[/vimeo\.com\/([0-9]*)/]
      vimeo_embed($1)
    else
      return nil
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
