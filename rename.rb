# This script was used to produce the custom_related.json data file from the related_words.rb hash upstream

# It is not needed for anything now since the hash has been converted into custom_related.json

# Only preserved here for novelty

require 'json'
require 'pp'
require './emoji_symbols.rb'
require './related_words.rb'

related = JSON.load(File.read('related.json'))
symbols = JSON.load(File.read('symbols.json'))

os = EMOJI_SYMBOLS.invert

# Invert EMOJI_SYMBOLS to perform new name -> symbol -> old name lookup
renamed = {}
symbols.each do |n, s|
  renamed[n] = os[s].to_s
end

# Map old RELATED_WORDS keys to new canonical emoji names
renamed_related = {}
renamed.each do |n, o|
  renamed_related[n] = RELATED_WORDS[o]
end

# Remove any related words that are in the canonical annotations list
unique = {}
renamed_related.each do |n, r|
  next unless r.is_a?(Array)
  # pp n
  # pp r
  # pp related[n]
  r.delete_if do |k|
    related[n].include?(k)
  end
  # pp r
  unique[n] = r unless r.empty?
end

# Save custom_related.json, a map from canonical names to custom related words (which will be merged with annotations by generate.rb)
File.open('custom_related.json', 'wb') { |f| f.write(JSON.pretty_generate(unique))}