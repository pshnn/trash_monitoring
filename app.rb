# frozen_string_literal: true

require 'sinatra'

require './gateways/redis_location_gateway'
require './presenters/json_presenter'

def location_gateway
  RedisLocationGateway.new
end

get '/' do
  locations = location_gateway.all.map do |l|
    Struct.new(
      :latitude,
      :longitude,
      :link
    ).new(
      l.latitude,
      l.longitude,
      "/location?latitude=#{l.latitude}&longitude=#{l.longitude}"
    )
  end

  erb :index, locals: { locations: locations }
end

get '/map' do
  erb :map, locals: { locations: location_gateway.all }
end

get '/location' do
  location = location_gateway.find_by_coordinates(
    Struct.new(:latitude, :longitude).new(params[:latitude], params[:longitude])
  )

  erb :location, locals: { location: location }
end

post '/register' do
  location_gateway.save(
    Struct.new(:latitude, :longitude).new(
      params['latitude'], params['longitude']
    )
  )

  redirect to '/'
end

get '/export/locations' do
  # location_gateway.all.to_s
  JsonPresenter.to_json(location_gateway.all)
end
