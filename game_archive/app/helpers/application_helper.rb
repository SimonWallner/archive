module ApplicationHelper
	require 'redcarpet'

  PREDEFINED_FIELDS = ["External Links", "Aggregate Scores", "Review Scores"]
	
	def markdown(text)

		rndr = LinksInNewWindow.new(:filter_html => true, :no_images => true, :hard_wrap => true)
		markdown = Redcarpet::Markdown.new(rndr, :space_after_headers => true, :autolink => true)
		markdown.render(text).html_safe
		
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

  def just_links_markdown(text)
    logger.debug "render just links"
    logger.debug text
    renderer = JustLinksRenderer.new :filter_html => true
    logger.debug "renderer initialised"
    markdown = Redcarpet::Markdown.new renderer, :autolink => true
    markdown.render(text).html_safe
  end

  # returns an array of MixedField Objects which fit the given type
  # object can be game, company, developer
  # type can be each MixedFieldType name (as symbols) or :all
  def get_mixed_fields(object, type)
    if type == nil || object == nil
      return Array.new
    end
    mf = object.mixed_fields
    if type == :all
      return mf
    end
    return mf.find_all {|i| i.mixed_field_type.name == type.to_s }
  end

  def get_field(object, name)
    if object == nil || name == nil
      return Array.new
    end
    f = object.fields
    return f.find_all { |i| i.name == name }
  end

  def get_user_fields(object)
    if object == nil
      return Array.new
    end

    f = object.fields
    return f.find_all { |i| not PREDEFINED_FIELDS.include?(i.name) }
  end

  # returns a formatted date with additional info
  def format_date(date)
    if date == nil
      return ""
    end

    formatted_date = ""
    if date.day != nil
      formatted_date = formatted_date + date.day.to_s + "."
    end
    if date.month != nil
      formatted_date = formatted_date + date.month.to_s + "."
    end
    if date.year != nil
      formatted_date = formatted_date + date.year.to_s
    end
    if date.additional_info != nil
      formatted_date = formatted_date + " - " + date.additional_info
    end
    return formatted_date
  end
end
