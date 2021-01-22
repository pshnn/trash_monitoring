# frozen_string_literal: true

require 'json'
require 'redis'

# Gateway for location records using Redis
class RedisLocationGateway
  LOCATIONS_COLLECTION_NAME = 'locations'

  def save(data)
    locations << {
      'latitude' => data.latitude,
      'longitude' => data.longitude
    }

    client.set(LOCATIONS_COLLECTION_NAME, locations.to_json)
  end

  def all
    return [] if locations.empty?

    locations.map do |location|
      Struct.new(
        :latitude,
        :longitude
      ).new(
        location['latitude'],
        location['longitude']
      )
    end
  end

  def delete_all
    setup_empty_locations_array

    @locations = []
  end

  def find_by_coordinates(location)
    all.find do |l|
      l.latitude == location.latitude && l.longitude == location.longitude
    end
  end

  private

  def locations
    setup_empty_locations_array if client.get(LOCATIONS_COLLECTION_NAME).nil?

    @locations ||= JSON.parse(client.get(LOCATIONS_COLLECTION_NAME))
  end

  def setup_empty_locations_array
    client.set(LOCATIONS_COLLECTION_NAME, [].to_json)
  end

  def client
    @client ||= Redis.new(url: ENV['REDIS_URL'])
  end
end
