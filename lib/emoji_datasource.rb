# frozen_string_literal: true

require 'json'

require_relative 'emoji_datasource/version'
require_relative 'emoji_datasource/emoji'
require_relative 'emoji_datasource/short_name_to_char'

module EmojiDatasource
  class Error < StandardError; end

  EMOJI_DATA_PATH = File.join(__dir__, '..', 'vendor', 'emoji-datasource', 'emoji.json')

  def self.short_name_to_char(name)
    EmojiDatasource::ShortNameToChar.generate(name)
  end

  def self.find_by_short_name(name)
    return unless name

    data.detect do |emoji|
      emoji.short_name == name || emoji.short_names.include?(name)
    end
  end

  def self.unified_to_char(unified_name)
    return unless unified_name

    unified_name.split('-').map(&:hex).pack('U*')
  end

  def self.data
    @data ||= JSON.parse(File.read(EMOJI_DATA_PATH), symbolize_names: true)
      .map { |emoji_data| EmojiDatasource::Emoji.new(emoji_data) }
  end
end

# Preload emojies on startup
EmojiDatasource.data
