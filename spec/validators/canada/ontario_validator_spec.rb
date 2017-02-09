RSpec.describe HealthCard::Validators::Canada::OntarioValidator do

  let(:validator) { described_class.new }

  describe '#card_valid?' do

    subject { validator.card_valid?(card_value) }

    context 'when the card value is correct' do
      let(:card_value) { '9876-543-217' }
      it { is_expected.to eq(true) }
    end

    context 'when the card value is not correct' do

      context 'because of the length' do
        before(:example) { allow(validator).to receive(:validate_checksum).and_return(true) }
        let(:card_value) { '98765432170' }
        it { is_expected.to eq(false) }
      end

      context 'because the first digit is a zero' do
        before(:example) { allow(validator).to receive(:validate_checksum).and_return(true) }
        let(:card_value) { '0876543217' }
        it { is_expected.to eq(false) }
      end

      context 'because of the format' do
        before(:example) { allow(validator).to receive(:validate_checksum).and_return(true) }
        let(:card_value) { '9A76543217' }
        it { is_expected.to eq(false) }
      end

      context 'because of the checksum' do
        let(:card_value) { '9876543210' }
        it { is_expected.to eq(false) }
      end

    end

    context 'when the card value has a version' do

      context 'and the version is valid with one letter' do
        let(:card_value) { '9876-543-217 A' }
        it { is_expected.to eq(true) }
      end

      context 'and the version is valid with two letters' do
        let(:card_value) { '9876-543-217 AA' }
        it { is_expected.to eq(true) }
      end

      context 'but the version is invalid' do
        let(:card_value) { '9876-543-217 AAA' }
        it { is_expected.to eq(false) }
      end

    end

    context 'when the checksum should be skipped' do
      subject { validator.card_valid?(card_value, options) }
      let(:card_value) { '9876-543-210' }
      let(:options) { { skip_checksum: true } }
      it { is_expected.to eq(true) }
    end

  end

  describe '#card_valid!' do

    let(:card_value) { double(:card_value) }
    subject { validator.card_valid!(card_value) }

    context 'when the card value is correct' do
      before(:example) { allow(validator).to receive(:card_valid?).with(card_value, {}).and_return(true) }
      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when the card value is incorrect' do
      before(:example) { allow(validator).to receive(:card_valid?).with(card_value, {}).and_return(false) }
      it 'raises an exception' do
        expect { subject }.to raise_error(HealthCard::Errors::InvalidCardValueError)
      end
    end

  end

end
