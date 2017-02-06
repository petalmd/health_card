class HealthCard

  def self.card_valid?(card_value, iso3166_code, validation_info = {})
    validator = get_validator(iso3166_code)
    validator.new.card_valid?(card_value, validation_info)
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

end

require 'health_card/string'

require 'health_card/errors/no_validator_error'

require 'health_card/validators/base_validator'
require 'health_card/validators/canada/quebec_validator'
require 'health_card/validators/canada/ontario_validator'
