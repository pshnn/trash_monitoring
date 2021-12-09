# frozen_string_literal: true

describe RedisLocationGateway do
  let(:gateway) { described_class.new }

  let(:create_location) do
    gateway.save(
      Struct.new(
        :latitude,
        :longitude
      ).new(
        54.2374627634,
        34.9823742634
      )
    )
  end

  before do
    described_class.new.delete_all
  end

  describe '#find_by_coordinates' do
    context 'when there is no location with such coordinates' do
      it 'returns nil' do
        location_data = Struct.new(:latitude, :longitude).new(34.346245235, 87.12341253522)

        expect(gateway.find_by_coordinates(location_data)).to be_nil
      end
    end

    context 'when there is location with same coordinates' do
      let(:latitude) { 34.346245235 }
      let(:longitude) { 87.1234125352 }

      it 'returns object with proper latitude' do
        location_data = Struct.new(:latitude, :longitude).new(latitude, longitude)

        gateway.save(location_data)

        location = gateway.find_by_coordinates(location_data)
        expect(location.latitude).to eq location_data.latitude
      end

      it 'returns object with proper longitude' do
        location_data = Struct.new(:latitude, :longitude).new(latitude, longitude)

        gateway.save(location_data)

        location = gateway.find_by_coordinates(location_data)
        expect(location.longitude).to eq location_data.longitude
      end
    end

    context 'when there is location with same coordinates and coordinates passed as string' do
      let(:latitude) { '34.346245235' }
      let(:longitude) { '87.1234125352' }

      it 'returns object with proper latitude' do
        location_data = Struct.new(:latitude, :longitude).new(latitude, longitude)

        gateway.save(location_data)

        location = gateway.find_by_coordinates(location_data)
        expect(location.latitude).to eq location_data.latitude
      end

      it 'returns object with proper longitude' do
        location_data = Struct.new(:latitude, :longitude).new(latitude, longitude)

        gateway.save(location_data)

        location = gateway.find_by_coordinates(location_data)
        expect(location.longitude).to eq location_data.longitude
      end
    end
  end

  describe '#delete_all' do
    context 'when there was no records' do
      it 'does nothing' do
        gateway.delete_all

        expect(gateway.all).to be_empty
      end
    end

    context 'when there was some records created' do
      it 'deletes all location records' do
        create_location

        gateway.delete_all

        expect(gateway.all).to be_empty
      end
    end
  end

  describe '#delete' do
    context 'when location with passed coordinates exists in database and ' \
      'coordinates passed as float values' do
      let(:latitude) { 35.346245235 }
      let(:longitude) { 82.12125352 }

      it 'removes location with same coordinates as passed' do
        location_data = Struct.new(:latitude, :longitude).new(latitude, longitude)
        gateway.save(location_data)

        gateway.delete(location_data)
        expect(gateway.find_by_coordinates(location_data)).to be_nil
      end
    end

    context 'when location with passed coordinates exists in database and ' \
      'coordinates passed as string values' do
      let(:latitude) { '35.346245235' }
      let(:longitude) { '82.12125352' }

      it 'removes location with same coordinates as passed' do
        location_data = Struct.new(:latitude, :longitude).new(latitude.to_f, longitude.to_f)
        gateway.save(location_data)

        gateway.delete(location_data)
        expect(gateway.find_by_coordinates(location_data)).to be_nil
      end
    end
  end

  describe '#all' do
    context 'when there is no saved locations' do
      it 'returns empty object' do
        expect(gateway.all).to be_empty
      end

      it 'returns array' do
        expect(gateway.all).to be_kind_of Array
      end
    end

    context 'when there is one saved location' do
      it 'returns array' do
        create_location

        expect(gateway.all).to be_kind_of Array
      end

      it 'returns not empty object' do
        create_location

        expect(gateway.all).not_to be_empty
      end
    end
  end

  describe '#count' do
    context 'when there is no locations' do
      it 'returns 0' do
        expect(gateway.count).to eq 0
      end
    end

    context 'when there are some locations' do
      before do
        3.times do
          gateway.save(
            Struct.new(
              :latitude,
              :longitude
            ).new(
              54.2374627634,
              34.9823742634
            )
          )
        end
      end

      it 'returns number of locations' do
        expect(gateway.count).to eq 3
      end
    end
  end
end
