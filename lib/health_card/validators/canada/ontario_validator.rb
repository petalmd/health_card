module HealthCard::Validators
  module Canada
    class OntarioValidator < HealthCard::Validators::BaseValidator

      REGEX_VALIDATION = /\A[1-9]\d{9}[A-Z]{0,2}\z/

      def card_valid?(card_value, _info = {})

        card_value = minimize_value(card_value)

        validate_value(card_value) &&
            validate_checksum(card_value)

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
