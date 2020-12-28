# frozen_string_literal: true

module EmojiDatasource
  class Emoji
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def to_char
      EmojiDatasource.unified_to_char(data[:unified])
    end

    def skin_variations
      return unless @data[:skin_variations]

      @data[:skin_variations].transform_keys(&:to_s)
    end

    def method_missing(method_name, *arguments, &block)
      if @data.key?(method_name)
        @data[method_name]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      return true if @data.key?(method_name)

      super
    end

    def inspect
      "#{self.class.name}:#{short_name}"
    end

    def to_s
      to_char
    end

    def as_json
      @data
    end

    def to_json(**args)
      @data.to_json(**args)
    end
  end
end
