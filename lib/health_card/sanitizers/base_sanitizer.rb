module HealthCard::Sanitizers
  class BaseSanitizer

    include HealthCard::DiacriticsHelper

    # Sanitizes the specified card value for database storage using default
    # sanitization rules that would fit most countries/subdivisions.
    #
    # @param card_value [String] the card value to sanitize
    # @return [String] the sanitized card value
    def sanitize(card_value)
      remove_diacritics(card_value).upcase.gsub(/[^0-9A-Z]/i, '')
    end

  end
end
