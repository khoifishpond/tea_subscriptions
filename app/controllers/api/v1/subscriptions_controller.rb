class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end
  
  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find(params[:tea_id])

    subscription = Subscription.create(
      title: tea.name,
      price: 4.99,
      frequency: 2,
      tea_id: tea.id,
      customer_id: customer.id
    )
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def update
    subscription = Subscription.find(params[:subscription_id])
    subscription.update(status: 0)
    render json: SubscriptionSerializer.new(subscription)
  end
end