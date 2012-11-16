module ApplicationHelper
	def markdown(text)
		rndr = Redcarpet::Render::HTML.new(:filter_html => true, :no_images => true, :hard_wrap => true)
		markdown = Redcarpet::Markdown.new(rndr, :autolink => true, :space_after_headers => true)
		markdown.render(text).html_safe
	end
end
