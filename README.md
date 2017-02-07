# Health Card gem

Services and validations for government-issued health cards.

## Validators

A card value can be validated by means of the following methods:

### card_valid?, card_valid!

Validates the specified card value.

Usage:

`HealthCard.card_valid?(card_value, iso3166_code, validation_info)`

Parameters:

- `card_value` (`String`): the card value to be validated.
- `iso3166_code` (`String`): the ISO 3166 code that represents the country or country subdivision against which the card value should be validated.
- `validation_info` (`Hash`): extra informations about the card that may affect the card value's validation (eg. first and last name of the card bearer).

Return value:

`true` or `false`, whether the card value was determined to be valid or not.

Notes:

The `.card_valid!` version of the method will raise a `InvalidCardValueError` instead of returning `false`.

## Converters

A card value can be converted to other useful formats. The following methods are available:

### sanitize

Strips the specified card value to the bare minimum. It removes diacritics and all non-alphanumeric characters. 

Usage:

`HealthCard.sanitize(card_value, iso3166_code)`

Parameters:

- `card_value` (`String`): the card value to be sanitized.
- `iso3166_code` (`String`): the ISO 3166 code that represents the country or country subdivision for which the card value should be sanitized.

Return value:

The stripped-down card value.

### beautify

Formats the specified card value to how it would look like on an official card.

Usage:

`HealthCard.beautify(card_value, iso3166_code)`

Parameters:

- `card_value` (`String`): the card value to be beautified.
- `iso3166_code` (`String`): the ISO 3166 code that represents the country or country subdivision for which the card value should be displayed.

Return value:

The card value in the country or country subdivision's official format.

## ISO 3166 codes

Available countries or country subdivisions are:

- CA-ON (Canada, Ontario)
- CA-QC (Canada, Quebec)