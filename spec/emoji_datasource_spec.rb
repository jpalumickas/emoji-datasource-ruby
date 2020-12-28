# frozen_string_literal: true

RSpec.describe EmojiDatasource do
  it 'has a version number' do
    expect(EmojiDatasource::VERSION).not_to be nil
  end

  describe '.short_name_to_char' do
    it 'has correct char for +1::skin-tone-2' do
      expect(described_class.short_name_to_char('+1::skin-tone-2')).to eq('👍🏻')
    end

    it 'has correct char for +1' do
      expect(described_class.short_name_to_char('+1')).to eq('👍')
    end
  end
end
