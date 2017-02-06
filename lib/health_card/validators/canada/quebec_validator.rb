require 'date'

module HealthCard::Validators
  module Canada
    class QuebecValidator < HealthCard::Validators::BaseValidator

      REGEX_VALIDATION = /\A[A-Z]{4}\d{6}[1-9]\d\z/

      # Validates the specified card value against the Canada/Quebec validator.
      #
      # @param card_value [String] the card value to validate
      # @param info [Hash] additional info about the card that will be
      #   validated against the card value
      # @return [true, false] whether the card value is valid or not
      def card_valid?(card_value, info = {})

        card_value = minimize_value(card_value)

        is_valid = validate_value(card_value) &&
            validate_checksum(card_value, info[:birth_date])

        if info[:last_name] && info[:first_name]
          is_valid &&= validate_names(card_value, info[:last_name], info[:first_name])
        end

        if info[:birth_date] && info[:gender]
          is_valid &&= validate_birth_date(card_value, info[:birth_date], info[:gender])
        end

        is_valid

      end

      private

      def validate_value(card_value)
        is_valid = validate_format(minimize_value(card_value), REGEX_VALIDATION)

        year = card_value[4..5].to_i
        month = card_value[6..7].to_i % 50
        day = card_value[8..9].to_i

        date_valid = Date.valid_date?(1900 + year, month, day) || Date.valid_date?(2000 + year, month, day)

        is_valid && date_valid
      end

      def validate_names(card_value, last_name, first_name)
        chars = last_name[0..2].ljust(3, 'X')
        chars += first_name[0]

        card_value[0..3].downcase == HealthCard::Helpers::DiacriticsHelper.remove_diacritics(chars).downcase.gsub(/[^a-z]/i, '')
      end

      def validate_birth_date(card_value, birth_date, gender)
        year = (birth_date.year % 100).to_s.rjust(2, '0')

        month = birth_date.month
        month += 50 if gender != :male
        month = month.to_s.rjust(2, '0')

        day = birth_date.day.to_s.rjust(2, '0')

        digits = year + month + day

        card_value[4..9] == digits
      end

      def validate_checksum(card_value, birth_date = nil)
        if birth_date
          calculate_checksum(card_value, birth_date.year / 100).to_s == card_value[11]
        else
          # Tries the checksum values for someone born in 19XX or 20XX.
          calculate_checksum(card_value, 19).to_s == card_value[11] ||
              calculate_checksum(card_value, 20).to_s == card_value[11]
        end
      end

      def calculate_checksum(card_value, century)
        digits = card_value[0..3]
                     .downcase
                     .chars
                     .flat_map { |letter| self.class.letter_to_code(letter) }

        # We need the actual birth year to include the century in the checksum.
        date = century.to_s + card_value[4..9]
        digits += date.chars.collect(&:to_i)

        digits << card_value[10].to_i

        is_female = false
        if digits[6] >= 5
          is_female = true
          digits[6] -= 5
        end

        checksum = 0
        [7, 1, 1, 3, 9, 7, 3, 9, 5, 3, 1, 3, 5, 7, 6, 9, 1].each_with_index do |m, i|
          checksum += digits[i] * m
        end

        checksum += 4 if is_female

        checksum % 10
      end

      def self.letter_to_code(letter)
        # Make `a` start at 1.
        code = letter.ord - 96

        # Yes. There's an imaginary letter between `r` and `s`. O_o
        code += 1 if code > 18

        [code / 10, code % 10]
      end

    end
  end
end
