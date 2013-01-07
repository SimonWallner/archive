class JustLinksRenderer < Redcarpet::Render::HTML

  def initialize(opts = {})
    opts[:tables] = false
    super(opts)
  end

  def codespan(code)
    "`" + code + "`"
  end

  def double_emphasis(text)
    "**" + text + "**"
  end

  def emphasis(text)
    "*" + text + "*"
  end

  def image(link, title, alt_text)
    nil
  end

  def linebreak()
    nil
  end

  def triple_emphasis(text)
    "***" + text + "***"
  end

  def strikethrough(text)
    "~" + text + "~~"
  end

  def superscript(text)
    "^" + text
  end

  def block_code(code, language)
    code
  end

  def block_quote(quote)
    "> " + quote
  end

  def header(text, header_level)
    header_indicator = ""
    header_level.times do
      header_indicator = header_indicator + "#"
    end
    header_indicator + text
  end

  def hrule()
    " "
  end

  def list(contents, list_type)
    " #{contents}"
  end

  def list_item(text, list_type)
    "* #{text}"
  end

  def paragraph(text)
    text
  end

  def postprocess(document)
    document.gsub("\n", ' ').strip
  end

end