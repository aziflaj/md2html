class MdHtml
  def initialize(markdown)
    @markdown = markdown
  end
  
  def to_html
    convert_headers
    convert_strong
    convert_italic
    convert_strikethrough
    convert_code
    convert_codeblock
    convert_links
    convert_lists
    convert_ordered_lists
    """
      <html>
      <head>
        <title>md2html by Aldo Ziflaj</title>
      </head>
      <body>
        #{@markdown}
      </body>
      </html>
    """
  end

  private
    def convert_headers
      @markdown.gsub(/^\#{1,6}.*$/) do |header|
        weight = 0
        header.split('').each do |char|
          break unless char == '#'
          weight += 1
        end
        content = header.sub(/^\#{1,6}/, '')
        "<h#{weight}>#{content}</h#{weight}>"
      end
    end

    def convert_strong
      @markdown.gsub(/\*{2}.*\*{2}|_{2}.*_{2}/) do |strong|
        content = strong.gsub(/\*{2}|_{2}/, '')
        "<strong>#{content}</strong>"
      end
    end

    def convert_italic
      @markdown.gsub(/\*{1}(\w|\s)+\*{1}|_{1}(\w|\s)+_{1}/) do |italic|
        content = italic.gsub(/\*{1}|_{1}/, '')
        "<em>#{content}</em>"
      end
    end

    def convert_strikethrough
      @markdown.gsub(/~(\w|\s)+~/) do |strike|
        content = strike.gsub(/~/, '')
        "<strike>#{content}</strike>"
      end
    end

    def convert_code
      @markdown.gsub(/`(\w|\s)+`/) do |code|
        content = code.gsub(/`/, '')
        "<code>#{content}</code>"
      end
    end

    def convert_codeblock
      @markdown.gsub(/```\w*(.*(\r\n|\r|\n))+```/) do |code|
        lang = code.match(/```\w+/)[0].gsub(/`/, '')
        content = code.gsub(/```\w+/, '```').gsub(/`/, '')
        "<pre class=\"#{lang}\"><code>#{content}</code></pre>"
      end
    end

    def convert_links
      @markdown.gsub(/\[(\w|\s)+\]\((\w|\W)+\)/) do |anchor|
        link_text = anchor.match(/\[(\w|\s)+\]/)[0].gsub(/[\[\]]/, '')
        href = anchor.match(/\((\w|\W)+\)/)[0].gsub(/\(|\)/, '')
        "<a href=\"#{href}\">#{link_text}</a>"
      end
    end

    def convert_lists
      @markdown.gsub(/(\-.+(\r|\n|\r\n))+/) do |list|
        items = "<ul>\n"
        list.gsub(/\-.+/) do |li|
          items << "<li>#{li.sub(/^\-/, '').strip}</li>\n"
        end
        items << "</ul>\n"
      end
    end

    def convert_ordered_lists
      @markdown.gsub(/(\d\..+(\r|\n|\r\n))+/) do |list|
        items = "<ol>\n"
        list.gsub(/\d.+/) do |li|
          items << "<li>#{li.sub(/^\d\./, '').strip}</li>\n"
        end
        items << "</ol>\n"
      end
    end
end
