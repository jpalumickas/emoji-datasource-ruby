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

    context 'skin-tone emoji' do
      it 'has to be nil for skin-tone-1' do
        expect(described_class.short_name_to_char('skin-tone-1')).to be_nil
      end

      it 'has correct char for skin-tone-2' do
        expect(described_class.short_name_to_char('skin-tone-2')).to eq('🏻')
      end
    end
  end

  describe '.find_by_short_name' do
    it 'has correct emoji for +1' do
      expect(described_class.find_by_short_name('+1').name).to eq('THUMBS UP SIGN')
    end

    it 'finds emoji when code is surrounded by colons' do
      expect(described_class.find_by_short_name(':+1:').name).to eq('THUMBS UP SIGN')
    end

    it 'finds emoji variant when skin tone is provided' do
      expect(described_class.find_by_short_name(':+1::skin-tone-3:').unified).to eq('1F44D-1F3FC')
    end

    it 'does not find emoji when invalid skin tone passed' do
      expect(described_class.find_by_short_name(':+1::skin-tone-7:')).to be_nil
    end

    it 'does not find emoji when some semicolons are missing' do
      expect(described_class.find_by_short_name(':+1:skin-tone-2:')).to be_nil
    end

    it 'does not find emoji when skin tone variants used for an emoji that doesn\'t support it' do
      expect(described_class.find_by_short_name(':hamsa::skin-tone-2:')).to be_nil
    end

    it 'finds complex emoji with multiple equal skin tones by single skin tone' do
      expect(described_class.find_by_short_name(':people_holding_hands::skin-tone-2:')).to \
        eq(described_class.find_by_short_name(':people_holding_hands::skin-tone-2::skin-tone-2:'))
    end

    it 'doesn\'t override existing short skin toned emoji' do
      expect(described_class.find_by_short_name(':women_holding_hands::skin-tone-2:')).not_to \
        eq(described_class.find_by_short_name(':women_holding_hands::skin-tone-2::skin-tone-2:'))
    end
  end

  describe '.find_by_unified' do
    it 'has correct emoji for thumbs up emoji' do
      expect(described_class.find_by_unified('1F44D').to_char).to eq('👍')
    end

    it 'finds emoji variant when skin tone is provided' do
      expect(described_class.find_by_unified('1F44D-1F3FC').to_char).to eq('👍🏼')
    end

    it 'doesn\'t find anything when non-emoji codepoint is provided' do
      expect(described_class.find_by_unified('20')).to be_nil
    end

    it 'doesn\'t find anything when multiple emojis are provided' do
      expect(described_class.find_by_unified('1F44D-1F44D-1F44D')).to be_nil
    end
  end

  describe '.find_by_char' do
    it 'has correct emoji for thumbs up emoji' do
      expect(described_class.find_by_char('👍').name).to eq('THUMBS UP SIGN')
    end

    it 'finds emoji variant when skin tone is provided' do
      expect(described_class.find_by_char('👍🏼').unified).to eq('1F44D-1F3FC')
    end

    it 'doesn\'t find anything when non-emoji codepoint is provided' do
      expect(described_class.find_by_char('A')).to be_nil
    end

    it 'doesn\'t find anything when multiple emojis are provided' do
      expect(described_class.find_by_char('👍👍👍')).to be_nil
    end
  end

  describe '.data' do
    it 'has correct count' do
      expect(described_class.data.length).to eq(1854)
    end
  end
end
