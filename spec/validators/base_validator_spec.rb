RSpec.describe HealthCard::Validators::BaseValidator do

  describe '.card_valid?' do

    let(:validator) { described_class.new }

    it 'raises an exception' do
      expect { validator.card_valid?('hin') }.to raise_error(NotImplementedError)
    end

  end

end
