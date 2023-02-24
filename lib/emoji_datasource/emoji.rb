# frozen_string_literal: true

module EmojiDatasource
  class Emoji
    attr_reader :data, :unified

    def initialize(data, variation: nil)
      @data = data
      @variation = variation
      @unified = variation ? @data.dig('skin_variations', variation, 'unified') : @data['unified']
    end

    # Raw emoji string
    def to_char
      EmojiDatasource.unified_to_char(unified)
    end

    # Official emoji name (pretty long)
    def name
      return @data['name'] unless @variation

      "#{@data['name']} (#{variation_emojis.map(&:name).join(', ')})"
    end

    # Short code that often can be used to find emoji in pickers and chat apps
    def short_name
      return @data['short_name'] unless @variation

      "#{@data['short_name']}::#{variation_emojis.map(&:short_name).join('::')}"
    end

    # All known short names (base +short_name+ and maybe some aliases)
    def short_names
      return @data['short_names'] unless @variation

      @data['short_names'].map do |short_name|
        "#{short_name}::#{variation_emojis.map(&:short_name).join('::')}"
      end
    end

    # All known skin tone variations
    def variations
      return @variations = [] if @variation

      @variations ||= @data.fetch('skin_variations', {}).each_key.map do |key|
        self.class.new(data, variation: key)
      end
    end

    # Base emoji, without variations applied.
    # E.g. for `:+1::skin-tone-2:` base will be just `:+1:`
    def base
      return self unless @variation

      EmojiDatasource.find_by_unified(@data['unified'])
    end

    def method_missing(method_name, *arguments, &block)
      if @data.key?(method_name.to_s)
        @data[method_name.to_s]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      return true if @data.key?(method_name.to_s)

      super
    end

    def inspect
      "#{self.class.name}: :#{short_name}: (#{to_char})"
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

    private

    def variation_emojis
      return [] unless @variation

      @variation.split('-').map do |unified|
        EmojiDatasource.find_by_unified(unified)
      end
    end
  end
end
