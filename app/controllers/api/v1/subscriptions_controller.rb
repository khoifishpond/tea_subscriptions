class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end
  
  def create
    customer = Customer.find(params[:customer_id])
    tea = Tea.find(params[:tea_id])

    subscription = Subscription.new(subscription_params)
    subscription.title = tea.name
    subscription.save
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def update
    subscription = Subscription.find(params[:subscription_id])
    subscription.update(status: 0)
    render json: SubscriptionSerializer.new(subscription)
  end

  private

  def subscription_params
    params.permit(:price, :frequency, :tea_id, :customer_id)
  end
end