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
      # @return [String] the resulting card value, or the initial card value
      #   if the card value is invalid
      def beautify(card_value)
        value = sanitize(card_value)

        if HealthCard.card_valid?(value, 'CA-ON')
          _beautify(value)
        else
          card_value
        end
      end

      # Renders the specified card value for display in Canada/Ontario.
      #
      # @param card_value [String] the card value to beautify
      # @return [String] the resulting card value, or an InvalidCardValueError
      #   if the card value is invalid
      def beautify!(card_value)
        value = sanitize(card_value)

        if HealthCard.card_valid?(value, 'CA-ON')
          _beautify(value)
        else
          raise HealthCard::Errors::InvalidCardValueError, "Card value `#{card_value}` is invalid in Canada/Ontario."
        end
      end

      private

      def _beautify(value)
        display = "#{value[0..3]}-#{value[4..6]}-#{value[7..9]}"

        if value[10..11] != ''
          display += "-#{value[10..11]}"
        end

        display
      end

    end
  end
end
