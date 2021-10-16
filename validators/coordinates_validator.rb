# frozen_string_literal: true

# Validates incoming location data
class CoordinatesValidator
  NO_LATITUDE_ERROR = 'Latitude must be present'
  NO_LONGITUDE_ERROR = 'Longitude must be present'
  FLOAT_REGEXP = /[+-]?[\d_]+\.[\d_]+(e[+-]?[\d_]+)?\b|[+-]?[\d_]+e[+-]?[\d_]+\b/.freeze

  attr_reader :errors

  def initialize(data)
    @latitude = data.latitude
    @longitude = data.longitude

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
    add_error NO_LATITUDE_ERROR if coordinates_floatlike? latitude
  end

  def validate_longitude
    add_error NO_LONGITUDE_ERROR if coordinates_floatlike? longitude
  end

  def coordinates_floatlike?(coordinate)
    coordinate.to_s !~ FLOAT_REGEXP
  end

  def add_error(message)
    errors.push message
  end
end
