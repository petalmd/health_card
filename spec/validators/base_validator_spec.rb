RSpec.describe HealthCard::Validators::BaseValidator do

  let(:validator) { described_class.new }

  describe '.card_valid?' do

    it 'raises an exception' do
      expect { validator.card_valid?('value') }.to raise_error(NotImplementedError)
    end

  end

  describe '.card_valid!' do

    it 'raises an exception' do
      expect { validator.card_valid?('value') }.to raise_error(NotImplementedError)
    end

  end

end
