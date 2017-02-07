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
      # @return [String] the resulting card value, or the initial card value
      #   if the card value is invalid
      def beautify(card_value)
        value = sanitize(card_value)

        if HealthCard.card_valid?(value, 'CA-QC')
          _beautify(value)
        else
          card_value
        end
      end

      # Renders the specified card value for display in Canada/Quebec.
      #
      # @param card_value [String] the card value to beautify
      # @return [String] the resulting card value, or an InvalidCardValueError
      #   if the card value is invalid
      def beautify!(card_value)
        value = sanitize(card_value)

        if HealthCard.card_valid?(value, 'CA-QC')
          _beautify(value)
        else
          raise HealthCard::Errors::InvalidCardValueError, "Card value `#{card_value}` is invalid in Canada/Quebec."
        end
      end

      private

      def _beautify(value)
        "#{value[0..3]} #{value[4..7]} #{value[8..11]}"
      end

    end
  end
end
