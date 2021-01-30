# frozen_string_literal: true

# Gateway for working with location records in application memory
class InMemoryLocationGateway
  def save(data)
    locations << Struct.new(:latitude, :longitude).new(
      data.latitude,
      data.longitude
    )
  end

  def all
    locations
  end

  def delete_all
    @locations = []
  end

  private

  def locations
    @locations ||= []
  end
end
