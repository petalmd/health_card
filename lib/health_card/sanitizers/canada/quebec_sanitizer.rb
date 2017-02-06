module HealthCard::Sanitizers
  module Canada
    class QuebecSanitizer < HealthCard::Sanitizers::BaseSanitizer

      # Sanitizes the specified card value for Canada/Quebec.
      #
      # @param card_value [String] the card value to sanitize
      # @return [String] the sanitized card value 
      def sanitize(card_value)
        super
      end

    end
  end
end
