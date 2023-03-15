# frozen_string_literal: true

require 'json'

require_relative 'emoji_datasource/version'
require_relative 'emoji_datasource/emoji'

module EmojiDatasource
  class Error < StandardError; end

  EMOJI_DATA_PATH = File.join(__dir__, '..', 'vendor', 'emoji-datasource', 'emoji.json')

  # @example
  #   short_name_to_char('+1') #=> "👍"
  def self.short_name_to_char(name)
    find_by_short_name(name)&.to_char
  end

  # Finds emoji by short code (e.g. `+1`, `:+1:`, `:+1::skin-tone-5:`)
  # @param name [String] short code with or without wrapping colons.
  # @return [EmojiDatasource::Emoji] if there is an emoji matching +name+
  # @return [nil] if there are no emojis matching +name+
  # @example
  #   find_by_short_name('+1') #=> EmojiDatasource::Emoji: :+1: (👍)
  def self.find_by_short_name(name)
    return unless name

    name = name.delete_prefix(':').delete_suffix(':') # Allow to find `+1` by `:+1:`
    name.delete_suffix!('::skin-tone-1') # special case for default skin tone
    short_name_lookup_map[name]
  end

  # Finds emoji by unified hex representation of Unicode codepoints
  # @param unified [String] Dash separated hexadecimal Unicode character codes for a single emoji
  # @return [EmojiDatasource::Emoji] if given Unicode codepoints is a known emoji
  # @return [nil] if there are no emojis with given codepoints in the dataset
  # @example
  #   short_name_to_char('1F44D') #=> EmojiDatasource::Emoji: :+1: (👍)
  def self.find_by_unified(unified)
    unified_lookup_map[unified.upcase]
  end

  # Find emoji object by raw Unicode string with a single emoji in it
  # @param raw_emoji [String] Single emoji
  # @return [EmojiDatasource::Emoji] if given string contains a single known emoji
  # @return [nil] if there are no such emoji in the dataset
  # @example
  #   find_by_char('👍') #=> EmojiDatasource::Emoji: :+1: (👍)
  def self.find_by_char(raw_emoji)
    find_by_unified(char_to_unified(raw_emoji))
  end

  def self.unified_to_char(unified_name)
    return unless unified_name

    unified_name.split('-').map(&:hex).pack('U*')
  end

  def self.char_to_unified(raw_emoji)
    return unless raw_emoji

    raw_emoji.unpack('U*').map { |c| c.to_s(16).upcase }.join('-')
  end

  def self.data
    @data ||= JSON.parse(File.read(EMOJI_DATA_PATH))
      .map { |emoji_data| EmojiDatasource::Emoji.new(emoji_data) }
  end

  # Utility hash map to search by emoji short code, including variants
  # @api private
  def self.short_name_lookup_map
    @short_name_lookup_map ||= data.each_with_object({}) do |emoji, result|
      emoji.short_names.each { |short_name| result[short_name] = emoji }
      emoji.variations.each do |emoji_variant|
        emoji_variant.short_names.each do |short_name|
          result[short_name] = emoji_variant
        end
      end
    end
  end

  # Utility hash map to search by unicode character sequence hex codes, including variants
  # @api private
  def self.unified_lookup_map
    @unified_lookup_map ||= data.each_with_object({}) do |emoji, result|
      result[emoji.unified] = emoji
      emoji.variations.each do |emoji_variant|
        result[emoji_variant.unified] = emoji_variant
      end
    end
  end
end

# Preload emojies on startup
EmojiDatasource.data
