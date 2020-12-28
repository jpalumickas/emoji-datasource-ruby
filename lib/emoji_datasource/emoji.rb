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
  end
end
