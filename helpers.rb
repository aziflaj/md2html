def header_weight(header)
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

def header_content(header)
  header.sub(/^\#{1,6}/, '')
end
