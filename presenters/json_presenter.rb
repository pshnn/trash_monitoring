# frozen_string_literal: true

# Builds json strings from objects by its attributes.
class JsonPresenter
  def self.to_json(object)
    case object
    when Array
      object.map { |e| e.to_h.to_json }.to_s
    else
      object.to_h.to_json
    end
  end
end
