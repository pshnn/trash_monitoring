# frozen_string_literal: true

describe InMemoryLocationGateway do
  let(:gateway) { InMemoryLocationGateway.new }

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
        gateway.save(
          Struct.new(
            :latitude,
            :longitude
          ).new(
            '54.2374627634',
            '34.9823742634'
          )
        )

        expect(gateway.all).to be_kind_of Array
      end

      it 'returns not empty object' do
        gateway.save(
          Struct.new(
            :latitude,
            :longitude
          ).new(
            '54.2374627634',
            '34.9823742634'
          )
        )

        expect(gateway.all).not_to be_empty
      end
    end
  end

  describe '#save' do
    context 'when valid object was passed' do
      it 'saves new location' do
        location = Struct.new(:latitude, :longitude).new('54.2374627634', '34.9823742634')

        old_locations_count = gateway.all.count

        gateway.save(location)

        new_locations_count = gateway.all.count

        expect(new_locations_count).to be > old_locations_count
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
        gateway.save(
          Struct.new(
            :latitude,
            :longitude
          ).new(
            '54.2374627634',
            '34.9823742634'
          )
        )

        gateway.delete_all

        expect(gateway.all).to be_empty
      end
    end
  end
end
