require 'json'

related = JSON.load(File.read('related.json'))
symbols = JSON.load(File.read('symbols.json'))

def item_xml(options = {})
  <<-ITEM
  <item arg=#{options[:arg].encode(xml: :attr)} uid=#{options[:uid].encode(xml: :attr)}>
    <title>#{options[:title].encode(xml: :text)}</title>
    <subtitle>#{options[:subtitle].encode(xml: :text)}</subtitle>
    <icon>#{options[:path].encode(xml: :text)}</icon>
  </item>
  ITEM
end

def match?(word, query)
  word.match(/#{query}/i)
end

images_path = File.expand_path('../images/emoji', __FILE__)

query = Regexp.escape(ARGV.first).delete(':')

related_matches = related.select { |k, v| match?(k, query) || v.any? { |r| match?(r, query) } }

# 1.8.7 returns a [['key', 'value']] instead of a Hash.
related_matches = related_matches.respond_to?(:keys) ? related_matches.keys : related_matches.map(&:first)

image_matches = Dir["#{images_path}/*.png"].map { |fn| File.basename(fn, '.png') }.select { |fn| match?(fn, query) }

matches = image_matches + related_matches

items = matches.uniq.sort.map do |elem|
  path = File.join(images_path, "#{elem}.png")
  emoji_code = ":#{elem}:"

  emoji_arg = ARGV.size > 1 ? symbols.fetch(elem, emoji_code) : emoji_code

  item_xml({ :arg => emoji_arg, :uid => elem, :path => path, :title => emoji_code,
             :subtitle => "Copy #{emoji_arg} to clipboard" }).force_encoding('UTF-8')
end.join

output = "<?xml version='1.0'?>\n<items>\n#{items}</items>"

puts output
