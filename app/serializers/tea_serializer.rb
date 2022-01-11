class TeaSerializer
  include JSONAPI::Serializer

  set_id :id
  attributes :name, :description, :temperature, :brew_time
end