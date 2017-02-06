module HealthCard::Validators
  class BaseValidator

    def card_valid?(_card_value, _info = {})
      raise NotImplementedError
    end

    private

    def validate_format(card_value, regex_validation)
      !!(card_value =~ regex_validation)
    end

    def minimize_value(card_value)
      card_value.upcase.gsub(/[^0-9A-Z]/i, '')
    end

  end
end
