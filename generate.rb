require 'nokogiri'
require 'open-uri'
require 'base64'

# doc = Nokogiri::HTML(open('http://unicode.org/emoji/charts/full-emoji-list.html'))
doc = File.open('full-emoji-list.html') { |f| Nokogiri::HTML(f) }

rows = doc.xpath('//table/tr')

details = rows.collect do |row|
  detail = {}

  detail[:index] = row.at_xpath('td[1]/text()').to_s.strip

  detail[:name] = row.at_xpath('td[13]/text()').to_s.strip

  detail[:notes] = row.css('td[16]/a').children.collect do |ann|
    ann.to_s
  end

  detail[:code] = [row.at_xpath('td[2]/a/text()').to_s[2..-1].to_s.hex].pack('U')

  # TODO: improve apple image selector
  begin
    detail[:icon] = Base64.decode64(row.css('td')[5].css('img').attr('src').to_s[22..-1])
  rescue
    detail[:icon] = nil
  end

  detail
end
