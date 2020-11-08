require "sinatra"

require "./gateways/redis_location_gateway"

location_gateway = RedisLocationGateway.new

get "/" do
  locations = location_gateway.get_all
  erb :index, locals: { locations: locations }
end

post "/register" do
  location_gateway.save(
    Struct.new(:latitude, :longitude).new(
      params["latitude"], params["longitude"]
    )
  )

  redirect to "/"
end
