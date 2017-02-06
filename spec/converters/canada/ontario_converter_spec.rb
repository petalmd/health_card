RSpec.describe HealthCard::Converters::Canada::OntarioConverter do

  let(:converter) { described_class.new }

  describe '.sanitize' do

    subject { converter.sanitize(card_value) }

    let(:card_value) { '1234-567-890-aa' }
    it { is_expected.to eq('1234567890AA') }

  end

  describe '.beautify' do

    subject { converter.beautify(card_value) }

    context 'when the card value is valid' do

      context 'and has a version' do
        let(:card_value)  { '1234567897aa' }
        it { is_expected.to eq('1234-567-897-AA')}
      end

      context 'and does not have a version' do
        let(:card_value)  { '1234567897' }
        it { is_expected.to eq('1234-567-897')}
      end

    end

    context 'when the card value is invalid' do
      let(:card_value)  { '123456789' }
      it 'raises an exception' do
        expect { subject }.to raise_error(HealthCard::Errors::InvalidCardValueError)
      end
    end

  end

end
