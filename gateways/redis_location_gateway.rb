# frozen_string_literal: true

require "json"
require "redis"

class RedisLocationGateway
  def save(data)
    locations << {
      "latitude" => data.latitude,
      "longitude" => data.longitude
    }

    client.set("locations", locations.to_json)
  end

  def get_all
    location_struct = Struct.new(:latitude, :longitude)

    locations.map do |location|
      location_struct.new(
        location["latitude"],
        location["longitude"]
      ) 
    end
  end

  private

  def locations
    create_locations_array if client.get("locations").nil?

    @locations ||= JSON.parse(client.get("locations"))
  end

  def create_locations_array
    client.set("locations", [].to_json)
  end

  def client
    @client ||= Redis.new(url: ENV["REDIS_URL"])
  end
end
