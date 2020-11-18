require "sinatra"

require "./gateways/redis_location_gateway"

def location_gateway
  RedisLocationGateway.new
end

def locations
  location_gateway.get_all
end

get "/" do
  erb :index, locals: { locations: locations }
end

get "/map" do
  erb :map, locals: { locations: locations }
end

post "/register" do
  location_gateway.save(
    Struct.new(:latitude, :longitude).new(
      params["latitude"], params["longitude"]
    )
  )

  redirect to "/"
end
