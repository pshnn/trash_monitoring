# frozen_string_literal: true

describe RoutesHelper do
  describe '.root_path' do
    it 'returns proper root path' do
      expect(described_class.root_path).to eq '/'
    end
  end

  describe '.map_path' do
    it 'returns proper map path' do
      expect(described_class.map_path).to eq '/map'
    end
  end

  describe '.edit_location_path' do
    context 'when coordinates were passed' do
      let(:latitude) { '34.1234567' }
      let(:longitude) { '87.1234567' }

      it 'returns proper edit location path' do
        expect(
          described_class.edit_location_path(latitude: latitude, longitude: longitude)
        ).to(eq("/locations/edit?latitude=#{latitude}&longitude=#{longitude}"))
      end
    end

    context 'when coordinates were not passed' do
      it 'returns proper edit location path' do
        expect(described_class.edit_location_path).to eq '/locations/edit'
      end
    end
  end

  describe '.delete_location_path' do
    context 'when coordinates were passed' do
      let(:latitude) { '34.1234567' }
      let(:longitude) { '87.1234567' }

      it 'returns proper edit location path' do
        expect(
          described_class.delete_location_path(latitude: latitude, longitude: longitude)
        ).to(eq("/locations?latitude=#{latitude}&longitude=#{longitude}"))
      end
    end

    context 'when coordinates were not passed' do
      it 'returns proper edit location path' do
        expect(described_class.delete_location_path).to eq '/locations'
      end
    end
  end

  describe '.import_locations_path' do
    it 'returns proper path' do
      expect(described_class.import_locations_path).to(eq('/import/locations'))
    end
  end
end
