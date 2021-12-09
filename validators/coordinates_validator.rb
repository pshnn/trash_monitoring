# frozen_string_literal: true

# Validates incoming location data
class CoordinatesValidator
  FLOAT_REGEXP = /[+-]?[\d_]+\.[\d_]+(e[+-]?[\d_]+)?\b|[+-]?[\d_]+e[+-]?[\d_]+\b/.freeze

  attr_reader :errors

  def initialize(data)
    @latitude = data.latitude.to_s
    @longitude = data.longitude.to_s

    @errors = []
  end

  class << self
    def validate(data)
      validator = new(data)

      validator.validate

      validator
    end
  end

  def validate
    validate_latitude
    validate_longitude
  end

  private

  attr_reader :latitude, :longitude

  def validate_latitude
    return add_error 'Latitude must be present' if coordinate_empty? latitude

    add_error 'Invalid latitude' if coordinate_floatlike? latitude
  end

  def validate_longitude
    return add_error 'Longitude must be present' if coordinate_empty? longitude

    add_error 'Invalid longitude' if coordinate_floatlike? longitude
  end

  def coordinate_floatlike?(coordinate)
    coordinate.to_s !~ FLOAT_REGEXP
  end

  def coordinate_empty?(coordinate)
    coordinate.nil? || coordinate.empty?
  end

  def add_error(message)
    errors.push message
  end
end
