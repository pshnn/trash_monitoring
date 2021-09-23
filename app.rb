# frozen_string_literal: true

require 'sinatra'

require 'honeybadger'

require './gateways/redis_location_gateway'
require './presenters/json_presenter'
require './helpers/routes_helper'

use Rack::Auth::Basic, 'Restricted Area' do |username, password|
  username == ENV['HTTP_AUTH_USERNAME'] && password == ENV['HTTP_AUTH_PASSWORD']
end

def location_gateway
  RedisLocationGateway.new
end

get RoutesHelper.root_path do
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

get RoutesHelper.map_path do
  erb :map, locals: { locations: location_gateway.all }
end

get '/location' do
  location = location_gateway.find_by_coordinates(
    Struct.new(:latitude, :longitude).new(params[:latitude], params[:longitude])
  )

  erb :location, locals: {
    location: location,
    edit_location_path: RoutesHelper.edit_location_path(
      latitude: location.latitude,
      longitude: location.longitude
    ),
    delete_location_path: RoutesHelper.delete_location_path(
      latitude: location.latitude,
      longitude: location.longitude
    )
  }
end

post '/register' do
  location_gateway.save(
    Struct.new(:latitude, :longitude).new(
      params[:latitude],
      params[:longitude]
    )
  )

  redirect to '/'
end

delete RoutesHelper.delete_location_path do
  location_gateway.delete(
    Struct.new(:latitude, :longitude).new(
      params[:latitude],
      params[:longitude]
    )
  )

  redirect to RoutesHelper.root_path
end

get '/export/locations' do
  JsonPresenter.to_json(location_gateway.all)
end

get RoutesHelper.import_locations_path do
  erb :import_locations, locals: { import_locations_path: RoutesHelper.import_locations_path, error_messages: [] }
end

post RoutesHelper.import_locations_path do
  gateway = RedisLocationGateway.new
  locations = JSON.parse(params[:locations])
  locations.map! { |location| JSON.parse(location) } if locations.first.is_a? String

  locations.each do |location|
    location_dto = Struct.new(:latitude, :longitude).new(location['latitude'], location['longitude'])
    next unless gateway.find_by_coordinates(location_dto).nil?

    gateway.save(location_dto)
  end

  redirect to RoutesHelper.root_path
rescue JSON::ParserError => e
  erb :import_locations,
      locals: {
        import_locations_path: RoutesHelper.import_locations_path,
        error_messages: ['Something went wrong', e.message]
      }
end
