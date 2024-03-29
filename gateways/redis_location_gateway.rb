# frozen_string_literal: true

require 'json'
require 'redis'

# Gateway for location records using Redis
class RedisLocationGateway
  LOCATIONS_COLLECTION_NAME = 'locations'

  def save(data)
    locations_data = parsed_locations_data

    locations_data << {
      'latitude' => data.latitude,
      'longitude' => data.longitude
    }

    client.set(LOCATIONS_COLLECTION_NAME, locations_data.to_json)
  end

  def all
    locations_data = parsed_locations_data

    return [] if locations_data.empty?

    locations_data.map do |location|
      Struct.new(:latitude, :longitude).new(
        location['latitude'],
        location['longitude']
      )
    end
  end

  def delete(data)
    locations_data = parsed_locations_data

    locations_data.delete(
      {
        'latitude' => data.latitude,
        'longitude' => data.longitude
      }
    )

    client.set(LOCATIONS_COLLECTION_NAME, locations_data.to_json)
  end

  def delete_all
    client.del(LOCATIONS_COLLECTION_NAME)
  end

  def find_by_coordinates(data)
    all.find do |l|
      l.latitude == data.latitude && l.longitude == data.longitude
    end
  end

  def count
    parsed_locations_data.count
  end

  private

  def parsed_locations_data
    data = client.get(LOCATIONS_COLLECTION_NAME)
    return JSON.parse('[]') if data.nil?

    JSON.parse(data)
  end

  def client
    @client ||= Redis.new(url: ENV['REDIS_URL'])
  end
end
