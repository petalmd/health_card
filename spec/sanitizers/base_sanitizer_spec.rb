RSpec.describe HealthCard::Sanitizers::BaseSanitizer do

  describe '.sanitize' do

    let(:sanitizer) { described_class.new }

    subject { sanitizer.sanitize(card_value) }

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

end
