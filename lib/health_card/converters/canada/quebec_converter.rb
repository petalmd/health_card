module HealthCard::Converters
  module Canada
    class QuebecConverter < HealthCard::Converters::BaseConverter

      # Sanitizes the specified card value for Canada/Quebec.
      #
      # @param card_value [String] the card value to sanitize
      # @return [String] the sanitized card value 
      def sanitize(card_value)
        super
      end

      # Renders the specified card value for display in Canada/Quebec.
      #
      # @param card_value [String] the card value to beautify
      # @return [String] the resulting card value
      def beautify(card_value)
        value = sanitize(card_value)

        if HealthCard.card_valid?(value, 'CA-QC')
          "#{value[0..3]} #{value[4..7]} #{value[8..11]}"
        else
          raise HealthCard::Errors::InvalidCardValueError, "Card value `#{card_value}` is invalid in Canada/Quebec."
        end
      end

    end
  end
end
