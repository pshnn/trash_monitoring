# frozen_string_literal: true

describe JsonPresenter do
  describe '#to_json' do
    let(:object) { Struct.new(:foo, :bar).new('fuz', 'baz') }

    it 'returns JSON string' do
      expect(JsonPresenter.to_json(object)).to be_kind_of String
    end

    context 'when single Struct was passed' do
      it 'returns JSON string with keys' do
        object.to_h.each_key do |key|
          expect(JsonPresenter.to_json(object)).to include key.to_s
        end
      end

      it 'returns JSON string with values' do
        object.to_h.each_value do |value|
          expect(JsonPresenter.to_json(object)).to include value.to_s
        end
      end

      it 'is valid JSON string' do
        expect { JSON.parse(JsonPresenter.to_json(object)) }.not_to raise_error
      end
    end

    context 'when array of structs was passed' do
      let(:collection) do
        [
          Struct.new(:foo, :bar).new('fuz', 'baz'),
          Struct.new(:foo, :bar).new('lsd', 'ios')
        ]
      end

      it 'returns JSON string with keys' do
        collection.each do |object|
          object.to_h.each_key do |key|
            expect(JsonPresenter.to_json(collection)).to include key.to_s
          end
        end
      end

      it 'returns JSON string with values' do
        collection.each do |object|
          object.to_h.each_value do |value|
            expect(JsonPresenter.to_json(collection)).to include value.to_s
          end
        end
      end
    end
  end
end
