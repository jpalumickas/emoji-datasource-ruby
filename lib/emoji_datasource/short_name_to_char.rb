# frozen_string_literal: true

module EmojiDatasource
  class ShortNameToChar
    def self.generate(name)
      new(name).call
    end

    attr_reader :short_name

    def initialize(short_name)
      @short_name = short_name
    end

    def call
      return unless short_name
      return EmojiDatasource.find_by_short_name(short_name)&.to_char unless skin_tone_matches

      emoji = EmojiDatasource.find_by_short_name(skin_tone_matches[1])
      return unless emoji

      char_with_skin_tone(emoji)
    end

    private

    def char_with_skin_tone(emoji)
      skin_variation = skin_tone_emoji && emoji.skin_variations[skin_tone_emoji.unified&.to_sym]
      return EmojiDatasource.unified_to_char(skin_variation[:unified]) if skin_variation

      "#{emoji.to_char}#{skin_tone_emoji.to_char}"
    end

    def skin_tone_emoji
      EmojiDatasource.find_by_short_name("skin-tone-#{skin_tone_level}")
    end

    def skin_tone_level
      skin_tone_matches[2]
    end

    def skin_tone_matches
      short_name.match(/:?(.+)::skin-tone-(\d+):?/)
    end
  end
end
