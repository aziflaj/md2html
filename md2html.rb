require './helpers'

if ARGV.count != 2
  puts "Usage: ruby md2html.rb <markdown> <html>"
  exit
else
  md_filename = ARGV[0]
  # html_filename = ARGV[1]
end

# md_file = File.open(md_filename)
md_file = IO.read(md_filename)
md_file.gsub!(/^\#{1,6}.*$/i) do |header|
  weight = header_weight header
  content = header_content header
  "<h#{weight}>#{content}</h#{weight}>"
end

# html_file = File.open(html_filename, "w")

puts md_file
