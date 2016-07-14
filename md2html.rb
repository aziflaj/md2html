require './md_html'

if ARGV.count != 2
  puts "Usage: ruby md2html.rb <markdown> <html>"
  exit
else
  md_filename = ARGV[0]
  # html_filename = ARGV[1]
end

# md_file = File.open(md_filename)
md_file = IO.read(md_filename)
md_file = MdHtml.convert_headers md_file
md_file = MdHtml.convert_strong md_file
md_file = MdHtml.convert_italic md_file

# html_file = File.open(html_filename, "w")

puts md_file
