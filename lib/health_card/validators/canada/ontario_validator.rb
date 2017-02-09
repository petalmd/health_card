module HealthCard::Validators
  module Canada
    class OntarioValidator < HealthCard::Validators::BaseValidator

      CONVERTER = HealthCard::Converters::Canada::OntarioConverter
      REGEX_VALIDATION = /\A[1-9]\d{9}[A-Z]{0,2}\z/

      # Validates the specified card value against the Canada/Ontario validator.
      #
      # @param card_value [String] the card value to validate
      # @param options [Hash] additional info about the card that will be
      #   validated against the card value
      # @return [true, false] whether the card value is valid or not
      def card_valid?(card_value, options = {})

        card_value = HealthCard.sanitize(card_value, 'CA-ON')

        is_valid = validate_value(card_value)

        unless options[:skip_checksum]
          is_valid &&= validate_checksum(card_value)
        end

        is_valid
      end

      # Validates the specified card value against the Canada/Ontario validator,
      # and raises an InvalidCardValueError if invalid.
      #
      # @param card_value [String] the card value to validate
      # @param options [Hash] additional info about the card that will be
      #   validated against the card value
      # @return [true] if the card is valid, raises an exception otherwise
      def card_valid!(card_value, options = {})
        unless card_valid?(card_value, options)
          raise HealthCard::Errors::InvalidCardValueError, "Card value `#{card_value}` is invalid in Canada/Ontario."
        end

        true
      end

      private

      def validate_value(card_value)
        validate_format(card_value, REGEX_VALIDATION)
      end

      def validate_checksum(card_value)
        calculate_checksum(card_value).to_s == card_value[9]
      end

      def calculate_checksum(card_value)
        values = card_value[0..8].chars.collect(&:to_i)

        [0, 2, 4, 6, 8].each do |i|
          values[i] *= 2

          if values[i] >= 10
            values[i] = values[i] / 10 + values[i] % 10
          end
        end

        10 - (values.reduce(:+) % 10)
      end

    end
  end
end
