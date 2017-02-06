class HealthCard

  # Validates the specified card value against a country/subdivision validator.
  #
  # @param card_value [String] the card value to validate
  # @param iso3166_code [String] the ISO 3166 code against which the card value
  #   must be validated. Country code must follow ISO 3166-1 alpha-2 code.
  #   {http://www.iso.org/iso/country_codes.htm}
  #   {https://en.wikipedia.org/wiki/ISO_3166}
  # @param validation_info [Hash] additional info about the card that will be
  #   validated against the card value, if necessary
  # @return [true, false] whether the card value is valid or not
  def self.card_valid?(card_value, iso3166_code, validation_info = {})
    validator = get_validator(iso3166_code)
    validator.new.card_valid?(card_value, validation_info)
  end

  def self.sanitize(card_value, iso3166_code)
    sanitizer = get_sanitizer(iso3166_code)
    sanitizer.new.sanitize(card_value)
  end

  private

  def self.get_validator(iso3166_code)

    case iso3166_code
      when 'CA-QC' then HealthCard::Validators::Canada::QuebecValidator
      when 'CA-ON' then HealthCard::Validators::Canada::OntarioValidator
      else
        raise HealthCard::Errors::NoValidatorError, "No validator defined for ISO 3166 code #{iso3166_code}."
    end

  end

  def self.get_sanitizer(iso3166_code)

    case iso3166_code
      when 'CA-QC' then HealthCard::Sanitizers::Canada::QuebecSanitizer
      when 'CA-ON' then HealthCard::Sanitizers::Canada::OntarioSanitizer
      else
        HealthCard::Sanitizers::BaseSanitizer
    end

  end

end

require 'health_card/errors/no_validator_error'

require 'health_card/helpers/diacritics_helper'

require 'health_card/sanitizers/base_sanitizer'
require 'health_card/sanitizers/canada/quebec_sanitizer'
require 'health_card/sanitizers/canada/ontario_sanitizer'

require 'health_card/validators/base_validator'
require 'health_card/validators/canada/quebec_validator'
require 'health_card/validators/canada/ontario_validator'
