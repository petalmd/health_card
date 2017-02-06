RSpec.describe HealthCard::Converters::BaseConverter do

  let(:converter) { described_class.new }

  describe '#sanitize' do

    subject { converter.sanitize(card_value) }

    context 'when the value has diacritics' do
      let(:card_value) { 'ÂBCDÉ0010' }
      it { is_expected.to eq('ABCDE0010') }
    end

    context 'when the value has spaces' do
      let(:card_value) { 'ABCDE 0010' }
      it { is_expected.to eq('ABCDE0010') }
    end

    context 'when the value has lowercase characters' do
      let(:card_value) { 'abcde0010' }
      it { is_expected.to eq('ABCDE0010') }
    end

    context 'when the value has non-alpha-numeric characters' do
      let(:card_value) { 'ABCDE-0010' }
      it { is_expected.to eq('ABCDE0010') }
    end

  end

  describe '#beautify' do

    subject { converter.beautify('any_value') }

    it 'raises an exception' do
      expect { subject }.to raise_error(NotImplementedError)
    end

  end

end
