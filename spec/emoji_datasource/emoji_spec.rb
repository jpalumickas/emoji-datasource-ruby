# frozen_string_literal: true

RSpec.describe EmojiDatasource::Emoji do
  describe '#to_char' do
    subject { emoji.to_char }

    context 'for base emoji' do
      let(:emoji) { EmojiDatasource.find_by_short_name(':+1:') }

      it { is_expected.to eq '👍' }
    end

    context 'for variant emoji' do
      let(:emoji) { EmojiDatasource.find_by_short_name(':+1::skin-tone-5:') }

      it { is_expected.to eq '👍🏾' }
    end
  end

  describe '#short_name' do
    subject { emoji.short_name }

    context 'for base emoji' do
      let(:emoji) { EmojiDatasource.find_by_unified('1F44D') }

      it { is_expected.to eq('+1') }
    end

    context 'for variant emoji' do
      let(:emoji) { EmojiDatasource.find_by_unified('1F44D-1F3FC') }

      it { is_expected.to eq('+1::skin-tone-3') }
    end
  end

  describe '#name' do
    subject { emoji.name }

    context 'for base emoji' do
      let(:emoji) { EmojiDatasource.find_by_unified('1F44D') }

      it { is_expected.to eq('THUMBS UP SIGN') }
    end

    context 'for variant emoji' do
      let(:emoji) { EmojiDatasource.find_by_unified('1F44D-1F3FB') }

      it { is_expected.to eq('THUMBS UP SIGN (EMOJI MODIFIER FITZPATRICK TYPE-1-2)') }
    end
  end

  describe '#base' do
    let(:base_emoji)    { EmojiDatasource.find_by_short_name(':+1:') }
    let(:variant_emoji) { EmojiDatasource.find_by_short_name(':+1::skin-tone-5:') }

    it 'should return itself for base emoji' do
      expect(base_emoji.base).to equal(base_emoji)
    end

    it 'should return base emoji for variant' do
      expect(variant_emoji.base).to equal(base_emoji)
    end
  end

  describe '#variations' do
    let(:base_emoji)    { EmojiDatasource.find_by_short_name(':+1:') }
    let(:variant_emoji) { EmojiDatasource.find_by_short_name(':+1::skin-tone-5:') }

    it 'should return variations for base emoji' do
      expect(base_emoji.variations).to include(variant_emoji)
    end

    it 'should return empty array for variant emoji' do
      expect(variant_emoji.variations).to be_empty
    end
  end
end
