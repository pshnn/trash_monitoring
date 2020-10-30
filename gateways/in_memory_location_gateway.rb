# frozen_string_literal: true

class InMemoryLocationGateway
  def save(data)
    locations << Struct.new(:latitude, :longitude).new(
      data.latitude,
      data.longitude
    )
  end

  def get_all
    locations
  end

  private

  def locations
    @locations ||= []
  end
end
