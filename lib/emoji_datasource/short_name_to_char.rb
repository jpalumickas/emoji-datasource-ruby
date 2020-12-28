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
      return emoji.to_char if skin_tone_level == 1

      char_with_skin_tone(emoji)
    end

    private

    def char_with_skin_tone(emoji)
      return unless skin_tone_emoji

      skin_variation = emoji.skin_variations && emoji.skin_variations[skin_tone_emoji.unified]
      return unless skin_variation

      EmojiDatasource.unified_to_char(skin_variation[:unified])
    end

    def skin_tone_emoji
      EmojiDatasource.find_by_short_name("skin-tone-#{skin_tone_level}")
    end

    def skin_tone_level
      skin_tone_matches[2].to_i
    end

    def skin_tone_matches
      short_name.match(/:?(.+)::skin-tone-(\d+):?/)
    end
  end
end
