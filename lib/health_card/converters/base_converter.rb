module HealthCard::Converters
  class BaseConverter

    include HealthCard::DiacriticsHelper

    # Sanitizes the specified card value for database storage using default
    # sanitization rules that would fit most countries/subdivisions.
    #
    # @param card_value [String] the card value to sanitize
    # @return [String] the sanitized card value
    def sanitize(card_value)
      if card_value
        card_value = remove_diacritics(card_value).upcase.gsub(/[^0-9A-Z]/i, '')
      end

      card_value
    end

    def beautify(_card_value)
      raise NotImplementedError
    end

    def beautify!(_card_value)
      raise NotImplementedError
    end

  end
end
