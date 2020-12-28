# frozen_string_literal: true

RSpec.describe EmojiDatasource do
  it 'has a version number' do
    expect(EmojiDatasource::VERSION).not_to be nil
  end

  describe '.short_name_to_char' do
    context '+1 emoji' do
      it 'has correct char for +1::skin-tone-2' do
        expect(described_class.short_name_to_char('+1::skin-tone-2')).to eq('👍🏻')
      end

      it 'has correct char for +1::skin-tone-1' do
        expect(described_class.short_name_to_char('+1::skin-tone-1')).to eq('👍')
      end

      it 'has correct char for +1' do
        expect(described_class.short_name_to_char('+1')).to eq('👍')
      end
    end

    context 'heart emoji' do
      it 'has correct char for heart' do
        expect(described_class.short_name_to_char('heart')).to eq('❤️')
      end

      it 'has to be nil for heart::skin-tone-2' do
        expect(described_class.short_name_to_char('heart::skin-tone-2')).to be_nil
      end
    end
  end

  describe '.find_by_short_name' do
    it 'has correct emoji for +1' do
      expect(described_class.find_by_short_name('+1').name).to eq('THUMBS UP SIGN')
    end
  end

  describe '.data' do
    it 'has correct count' do
      expect(described_class.data.length).to eq(1810)
    end
  end
end
