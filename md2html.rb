class MdHtml
  def to_html(markdown)
    markdown = convert_headers markdown
    markdown = convert_strong markdown
    markdown = convert_italic markdown
    markdown = convert_code markdown
    return <<-HTML
      <html>
      <head>
        <title>md2html by Aldo Ziflaj</title>
      </head>
      <body>
        #{markdown}
      </body>
      </html>
    HTML
  end

  private
    def convert_headers(markdown)
      markdown.gsub(/^\#{1,6}.*$/) do |header|
        weight = 0
        header.split("").each do |char|
          if char == '#'
            weight += 1
          else
            break
          end
        end
        content = header.sub(/^\#{1,6}/, '')
        "<h#{weight}>#{content}</h#{weight}>"
      end
    end

    def convert_strong(markdown)
      markdown.gsub(/\*{2}.*\*{2}|_{2}.*_{2}/) do |strong|
        content = strong.gsub(/\*{2}|_{2}/, '')
        "<strong>#{content}</strong>"
      end
    end

    def convert_italic(markdown)
      markdown.gsub(/\*{1}(\w|\s)+\*{1}|_{1}(\w|\s)+_{1}/) do |italic|
        content = italic.gsub(/\*{1}|_{1}/, '')
        "<em>#{content}</em>"
      end
    end

    def convert_code(markdown)
      markdown.gsub(/`(\w|\s)+`/) do |code|
        content = code.gsub(/`/, '')
        "<code>#{content}</code>"
      end
    end
end
