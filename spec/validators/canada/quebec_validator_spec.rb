RSpec.describe HealthCard::Validators::Canada::QuebecValidator do

  describe '#card_valid?' do

    let(:validator) { described_class.new }

    context 'when no info is specified' do

      context 'and the card value is correct' do

        it 'verifies the card value' do
          %w(
            AAAA01010112
            BAAA01010113
            ZAAA01010112
            ABAA01010115
            AZAA01010112
            AABA01010119
            AAZA01010112
            AAAB01010111
            AAAZ01010112
            AAAA02010115
            AAAA99010115
            AAAA01020119
            AAAA01120114
            AAAA01010211
            AAAA01013110
            AAAA01010123
            AAAA01010190
        ).each do |card_value|
            expect(validator.card_valid?(card_value)).to eq(true)
          end
        end

        it 'tries birth dates in 19XX and 20XX' do
          %w(
            AAAA01010112
            AAAA01010110
        ).each do |card_value|
            expect(validator.card_valid?(card_value)).to eq(true)
          end
        end

        it 'understands the `female` flag' do
          %w(
            AAAA01010112
            AAAA01510117
        ).each do |card_value|
            expect(validator.card_valid?(card_value)).to eq(true)
          end
        end

      end

      context 'but the card value is not correct' do

        subject { validator.card_valid?(card_value) }

        context 'because of the length' do
          before(:example) { allow(validator).to receive(:validate_checksum).and_return(true) }
          let(:card_value) { 'AAAA010101100' }
          it { is_expected.to eq(false) }
        end

        context 'because of the letters' do
          before(:example) { allow(validator).to receive(:validate_checksum).and_return(true) }
          let(:card_value) { 'AA3A01010110' }
          it { is_expected.to eq(false) }
        end

        context 'because of the date' do
          before(:example) { allow(validator).to receive(:validate_checksum).and_return(true) }
          let(:card_value) { 'AAAA01014110' }
          it { is_expected.to eq(false) }
        end

        context 'because of the count index' do
          before(:example) { allow(validator).to receive(:validate_checksum).and_return(true) }
          let(:card_value) { 'AAAA01010100' }
          it { is_expected.to eq(false) }
        end

        context 'because of the checksum' do
          let(:card_value) { 'AAAA01010119' }
          it { is_expected.to eq(false) }
        end

      end

    end

    context 'when info is specified' do

      let(:info) do
        {
            last_name: 'Last',
            first_name: 'First',
            birth_date: Date.new(1980, 2, 14),
            gender: :male
        }
      end

      # These tests are to validate discrepancies between the card value and
      # the provided informations. Without these info, they must pass all
      # validations.
      before(:example) { expect(validator.card_valid?(card_value)).to eq(true) }

      subject { validator.card_valid?(card_value, info) }

      context 'and the card value is correct' do
        let(:card_value) { 'LASF80021411' }
        it { is_expected.to eq(true) }
      end

      context 'and the card value is not correct' do

        context 'because of the last name' do
          let(:card_value) { 'LAAF80021410' }
          it { is_expected.to eq(false) }
        end

        context 'because of the first name' do
          let(:card_value) { 'LASA80021416' }
          it { is_expected.to eq(false) }
        end

        context 'because of the birth date' do
          let(:card_value) { 'LASF81021414' }
          it { is_expected.to eq(false) }
        end

        context 'because of the gender' do
          let(:card_value) { 'LASF80521416' }
          it { is_expected.to eq(false) }
        end

      end

    end

  end

end
