module HealthCard::Validators
  class BaseValidator

    def card_valid?(_card_value, _options = {})
      raise NotImplementedError
    end

    def card_valid!(_card_value, _options = {})
      raise NotImplementedError
    end

    private

    def validate_format(card_value, regex_validation)
      !!(card_value =~ regex_validation)
    end

  end
end
