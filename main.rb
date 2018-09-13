require './md2html'

if ARGV.count != 2
  puts "Usage: ruby md2html.rb <markdown> <html>"
  exit
end

md_filename, html_filename = ARGV
md_content = IO.read(md_filename)

html_content = MdHtml.new(md_content).to_html

File.open(html_filename, "w") {|file| file.write html_content}
