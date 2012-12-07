module ApplicationHelper
	require 'redcarpet'
	
	def markdown(text)

		rndr = LinksInNewWindow.new(:filter_html => true, :no_images => true, :hard_wrap => true)
		markdown = Redcarpet::Markdown.new(rndr, :space_after_headers => true, :autolink => true)
		markdown.render(text).html_safe
		
  end

  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    %Q{<iframe title="YouTube video player" width="688" height="349" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end





class LinksInNewWindow < Redcarpet::Render::HTML
    def link(link, title, alt_text)
      "<a target=\"_blank\" href=\"#{link}\">#{alt_text}</a>"
    end
    def autolink(link, link_type)
      if link[-1] =='/'
        link=link[0..-1]
      end
      link_title= link.split("/")
      link_end =""
      if link_title.length>5
        link_title=link_title[0..4]
        link_end = "/..."
      end
        link_t = link_title[2]
      for i in 3..link_title.length-1
        if link_title[i].length>20
          link_end = "/..."
          break
        end
        link_t += "/" + link_title[i]
      end
        link_t +=link_end
      "<a target=\"_blank\" href=\"#{link}\">#{link_t}</a>"
    end
  end
end
