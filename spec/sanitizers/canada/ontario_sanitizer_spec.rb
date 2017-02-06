RSpec.describe HealthCard::Sanitizers::Canada::OntarioSanitizer do

  describe '.sanitize' do

    it 'sanitizes the card value' do
      sanitized_value = described_class.new.sanitize('1234-567-890-aa')
      expect(sanitized_value).to eq('1234567890AA')
    end

  end

end
