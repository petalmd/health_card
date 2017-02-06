RSpec.describe HealthCard do

  describe '.card_valid?' do

    let(:card_value) { double(:card_value) }
    let(:validation_info) { double(:validation_info) }

    subject { described_class.card_valid?(card_value, iso3166_code, validation_info) }

    context 'when the ISO 3166 code is specified' do

      context 'as Canada/Quebec' do
        let(:iso3166_code) { 'CA-QC' }
        let(:validator_class) { HealthCard::Validators::Canada::QuebecValidator }
        let(:validator) { validator_class.new }
        it 'uses the correct validator' do
          allow(validator_class).to receive(:new).and_return(validator)
          expect(validator).to receive(:card_valid?).with(card_value, validation_info)
          subject
        end
      end

      context 'as Canada/Ontario' do
        let(:iso3166_code) { 'CA-ON' }
        let(:validator_class) { HealthCard::Validators::Canada::OntarioValidator }
        let(:validator) { validator_class.new }
        it 'uses the correct validator' do
          allow(validator_class).to receive(:new).and_return(validator)
          expect(validator).to receive(:card_valid?).with(card_value, validation_info)
          subject
        end
      end

      context 'but is invalid' do
        let(:iso3166_code) { 'invalid' }
        it 'raises an exception' do
          expect { subject }.to raise_error(HealthCard::Errors::NoValidatorError)
        end
      end

    end

  end

end
