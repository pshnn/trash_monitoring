# frozen_string_literal: true

require 'spec_helper'

describe CoordinatesValidator do
  describe '.validate' do
    let(:valid_data) { Struct.new(:latitude, :longitude).new('43.38', '87.34') }

    context 'when valid data passed' do
      it 'returns object with no errors' do
        expect(described_class.validate(valid_data).errors.count).to eq 0
      end
    end

    context 'when data passed with float like latitude' do
      let(:data) { Struct.new(:latitude, :longitude).new('43.38', '87.34') }

      it 'returns object with no errors' do
        [34.32453, 23.0, '34.0', '14.23424'].each do |latitude|
          expect(described_class.validate(
            Struct.new(:latitude, :longitude).new(latitude, '87.34')
          ).errors.count).to eq 0
        end
      end
    end

    context 'when data passed with not float like latitude' do
      let(:data) { Struct.new(:latitude, :longitude).new('sd687s6f7', '87.34') }

      it 'returns object with errors' do
        expect(described_class.validate(data).errors.count).to be > 0
      end
    end

    context 'when data passed with no latitude' do
      let(:data) do
        valid_data.latitude = nil

        valid_data
      end

      it 'returns object with errors' do
        expect(described_class.validate(data).errors.count).to be > 0
      end

      it 'returns object with proper error message' do
        expect(described_class.validate(data).errors).to(
          include('Latitude must be present')
        )
      end
    end

    context 'when data passed with no longitude' do
      let(:data) do
        valid_data.longitude = nil

        valid_data
      end

      it 'returns object with errors' do
        expect(described_class.validate(data).errors.count).to be > 0
      end

      it 'returns object with proper error message' do
        expect(described_class.validate(data).errors).to(
          include('Longitude must be present')
        )
      end
    end

    context 'when data passed with not float like longitude' do
      let(:data) { Struct.new(:latitude, :longitude).new('87.34', 'sd687s6f7') }

      it 'returns object with errors' do
        expect(described_class.validate(data).errors.count).to be > 0
      end
    end

    context 'when data passed with float like longitude' do
      let(:data) { Struct.new(:latitude, :longitude).new('43.38', '87.34') }

      it 'returns object with no errors' do
        [34.32453, 23.0, '34.0', '14.23424'].each do |coordinate|
          expect(described_class.validate(
            Struct.new(:latitude, :longitude).new('87.34', coordinate)
          ).errors.count).to eq 0
        end
      end
    end
  end
end
