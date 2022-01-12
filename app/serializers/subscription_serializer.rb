class SubscriptionSerializer
  include JSONAPI::Serializer

  set_id :id
  attributes :title, :price, :status, :frequency, :tea_id, :customer_id
end