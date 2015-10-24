require 'nokogiri'
require 'open-uri'
require 'base64'
require 'json'

doc = Nokogiri::HTML(open('http://unicode.org/emoji/charts/full-emoji-list.html'))
# doc = File.open('full-emoji-list.html') { |f| Nokogiri::HTML(f) }

rows = doc.xpath('//table/tr')

related = {}
symbols = {}

rows.each do |row|
  head = row.at_xpath('th[1]/text()').to_s.strip
  next if 'Count' == head

  name = row.at_xpath('td[13]/text()').to_s.strip
  filename = name.gsub(/\s/, '_').downcase

  icon = Base64.decode64(row.css('td.andr')[1].css('img').attr('src').to_s[22..-1])
  File.open("images/#{filename}.png", 'wb') do |f|
    f.write(icon)
  end


  notes = row.css('td[16]/a').children.collect { |ann| ann.to_s }
  related[filename] = notes

  symbol = [row.at_xpath('td[2]/a/text()').to_s[2..-1].to_s.hex].pack('U')
  symbols[filename] = symbol
end

File.open('symbols.json', 'wb') { |f| f.write(JSON.pretty_generate(symbols)) }
File.open('related.json', 'wb') { |f| f.write(JSON.pretty_generate(related)) }
