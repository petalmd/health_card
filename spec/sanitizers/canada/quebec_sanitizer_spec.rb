RSpec.describe HealthCard::Sanitizers::Canada::QuebecSanitizer do

  describe '.sanitize' do

    it 'sanitizes the card value' do
      sanitized_value = described_class.new.sanitize('aaaa 0123 4567')
      expect(sanitized_value).to eq('AAAA01234567')
    end

  end

end
