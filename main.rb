require './md2html'

if ARGV.count != 2
  puts "Usage: ruby md2html.rb <markdown> <html>"
  exit
else
  md_filename = ARGV[0]
  html_filename = ARGV[1]
end

md_content = IO.read(md_filename)

md_html_converter = MdHtml.new
html_content = md_html_converter.to_html md_content

File.open(html_filename, "w") {|file| file.write html_content}
