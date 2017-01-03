require 'nokogiri'
require 'open-uri'
require 'base64'
require 'json'

doc = Nokogiri::HTML(open('http://unicode.org/emoji/charts/full-emoji-list.html'))
# doc = File.open('full-emoji-list.html') { |f| Nokogiri::HTML(f) }

rows = doc.css('table tr')

related = {}
symbols = {}

custom_related = JSON.load(File.read('custom_related.json'))

rows.each do |row|
  # Skip header row of table
  next if 'Count' == row.at_xpath('th[1]/text()').to_s.strip

  # Replace spaces with _ in emoji name to make image filename
  filename = row.at_css('td.name').text.to_s.strip.gsub(/\s/, '_').downcase rescue nil
  next unless filename
  # Skip modifiers
  next if filename.include? ":"

  # Decode base64 image data for Apple icon and save to file
  icon = Base64.decode64(row.css('td.andr')[1].css('img').attr('src').to_s[22..-1]) rescue nil
  next unless icon
  File.open("images/emoji/#{filename}.png", 'wb') { |f| f.write(icon) }

  # Use annotations for related words
  annotations = row.css('td:last-child a').children.collect { |a| a.text }
  # Combine annotations with custom related words
  related[filename] = annotations.concat(custom_related[filename] || []).uniq

  # Read the unicode symbol
  symbols[filename] = [row.at_xpath('td[2]/a/text()').to_s[2..-1].to_s.hex].pack('U')
end


# Write data files used by emoji.rb
File.open('symbols.json', 'wb') { |f| f.write(JSON.pretty_generate(symbols)) }
File.open('related.json', 'wb') { |f| f.write(JSON.pretty_generate(related)) }
