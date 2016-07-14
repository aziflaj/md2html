class MdHtml
  def self.convert_headers(markdown)
    markdown.gsub(/^\#{1,6}.*$/) do |header|
      weight = header_weight header
      content = header_content header
      "<h#{weight}>#{content}</h#{weight}>"
    end
  end

  def self.convert_strong(markdown)
    markdown.gsub(/\*{2}.*\*{2}|_{2}.*_{2}/) do |strong|
      content = strong_content strong
      "<strong>#{content}</strong>"
    end
  end

  private
    def self.header_weight(header)
      weight = 0
      header.split("").each do |char|
        if char == '#'
          weight += 1
        else
          return weight
        end
      end
      return weight
    end

    def self.header_content(header)
      header.sub(/^\#{1,6}/, '')
    end

    def self.strong_content(strong)
      strong.gsub(/\*{2}|_{2}/, '')
    end
end
