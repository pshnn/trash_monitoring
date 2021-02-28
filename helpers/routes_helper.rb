# frozen_string_literal: true

# Builds routes for application
class RoutesHelper
  class << self
    def root_path
      '/'
    end

    def map_path
      '/map'
    end

    def edit_location_path(latitude: nil, longitude: nil)
      return '/locations/edit' unless latitude && longitude

      "/locations/edit?latitude=#{latitude}&longitude=#{longitude}"
    end

    def delete_location_path(latitude: nil, longitude: nil)
      return '/locations' unless latitude && longitude

      "/locations?latitude=#{latitude}&longitude=#{longitude}"
    end
  end
end
