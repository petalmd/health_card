module HealthCard::Converters
  module Canada
    class OntarioConverter < HealthCard::Converters::BaseConverter

      # Sanitizes the specified card value for Canada/Ontario.
      #
      # @param card_value [String] the card value to sanitize
      # @return [String] the sanitized card value
      def sanitize(card_value)
        super
      end

      # Renders the specified card value for display in Canada/Ontario.
      #
      # @param card_value [String] the card value to beautify
      # @return [String] the resulting card value
      def beautify(card_value)
        value = sanitize(card_value)

        if HealthCard.card_valid?(value, 'CA-ON')
          display = "#{value[0..3]}-#{value[4..6]}-#{value[7..9]}"

          if value[10..11] != ''
            display += "-#{value[10..11]}"
          end

          display
        else
          raise HealthCard::Errors::InvalidCardValueError, "Card value `#{card_value}` is invalid in Canada/Ontario."
        end
      end


    end
  end
end
