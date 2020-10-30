require "sinatra"

require "./gateways/in_memory_location_gateway"

location_gateway = InMemoryLocationGateway.new

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
