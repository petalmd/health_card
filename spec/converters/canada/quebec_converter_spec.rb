RSpec.describe HealthCard::Converters::Canada::QuebecConverter do

  let(:converter) { described_class.new }

  describe '.sanitize' do

    subject { converter.sanitize(card_value) }

    let(:card_value) { 'aaaa 0123 4567' }
    it { is_expected.to eq('AAAA01234567') }

  end

  describe '.beautify' do

    subject { converter.beautify(card_value) }

    context 'when the card value is valid' do
      let(:card_value)  { 'aaaa01010112' }
      it { is_expected.to eq('AAAA 0101 0112')}
    end

    context 'when the card value is invalid' do
      let(:card_value)  { 'aaaa0101011' }
      it 'raises an exception' do
        expect { subject }.to raise_error(HealthCard::Errors::InvalidCardValueError)
      end
    end

  end

end
