Dir[File.join(__dir__, "..", "gateways", "*.rb")].each { |file| require file }

describe RedisLocationGateway do
  let(:gateway) { RedisLocationGateway.new }

  before do
    RedisLocationGateway.new.delete_all
  end

  describe "#delete_all" do
    context "when there was no records" do
      it "does nothing" do
        gateway.delete_all

        expect(gateway.get_all).to be_empty
      end
    end

    context "when there was some records created" do
      it "deletes all location records" do
        gateway.save(
          Struct.new(
            :latitude,
            :longitude
          ).new(
            "54.2374627634",
            "34.9823742634"
          )
        )

        gateway.delete_all

        expect(gateway.get_all).to be_empty
      end
    end
  end

  describe "#get_all" do
    context "when there is no saved locations" do
      it "returns empty object" do
        expect(gateway.get_all).to be_empty
      end

      it "returns array" do
        expect(gateway.get_all).to be_kind_of Array
      end
    end

    context "when there is one saved location" do
      it "returns array" do
        gateway.save(
          Struct.new(
            :latitude,
            :longitude
          ).new(
            "54.2374627634",
            "34.9823742634"
          )
        )

        expect(gateway.get_all).to be_kind_of Array
      end

      it "returns not empty object" do
        gateway.save(
          Struct.new(
            :latitude,
            :longitude
          ).new(
            "54.2374627634",
            "34.9823742634"
          )
        )

        expect(gateway.get_all).not_to be_empty
      end
    end
  end
end

describe InMemoryLocationGateway do
  let(:gateway) { InMemoryLocationGateway.new }

  describe "#get_all" do
    context "when there is no saved locations" do
      it "returns empty object" do
        expect(gateway.get_all).to be_empty
      end

      it "returns array" do
        expect(gateway.get_all).to be_kind_of Array
      end
    end

    context "when there is one saved location" do
      it "returns array" do
        gateway.save(
          Struct.new(
            :latitude,
            :longitude
          ).new(
            "54.2374627634",
            "34.9823742634"
          )
        )

        expect(gateway.get_all).to be_kind_of Array
      end

      it "returns not empty object" do
        gateway.save(
          Struct.new(
            :latitude,
            :longitude
          ).new(
            "54.2374627634",
            "34.9823742634"
          )
        )

        expect(gateway.get_all).not_to be_empty
      end
    end
  end

  describe "#save" do
    context "when valid object was passed" do
      it "saves new location" do
        location = Struct.new(:latitude, :longitude).new("54.2374627634", "34.9823742634")

        old_locations_count = gateway.get_all.count

        gateway.save(location)

        new_locations_count = gateway.get_all.count

        expect(new_locations_count).to be > old_locations_count
      end
    end
  end

  describe "#delete_all" do
    context "when there was no records" do
      it "does nothing" do
        gateway.delete_all

        expect(gateway.get_all).to be_empty
      end
    end

    context "when there was some records created" do
      it "deletes all location records" do
        gateway.save(
          Struct.new(
            :latitude,
            :longitude
          ).new(
            "54.2374627634",
            "34.9823742634"
          )
        )

        gateway.delete_all

        expect(gateway.get_all).to be_empty
      end
    end
  end
end
