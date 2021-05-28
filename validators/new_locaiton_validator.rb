# frozen_string_literal: true

# Validates incoming location data
class NewLocationValidator
  NO_LATITUDE_ERROR = 'Latitude must be present'
  NO_LONGITUDE_ERROR = 'Longitude must be present'

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
    return if latitude.is_a?(Float) || latitude.is_a?(Integer)

    errors.push(NO_LATITUDE_ERROR) if latitude.nil? || latitude.empty?
  end

  def validate_longitude
    errors.push(NO_LONGITUDE_ERROR) if longitude.nil? || longitude.empty?
  end
end
