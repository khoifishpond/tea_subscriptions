class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(customer.subscriptions)
  end

  def show
    if params[:subscription_id].nil?
      render json: error('Subscription ID required')
    else
      subscription = Subscription.find(params[:subscription_id])
      render json: SubscriptionSerializer.new(subscription)
    end
  end
  
  def create
    if params[:customer_id].nil? || params[:tea_id].nil?
      render json: error('Customer and Tea ID required')
    else
      customer = Customer.find(params[:customer_id])
      tea = Tea.find(params[:tea_id])
  
      subscription = Subscription.new(subscription_params)
      subscription.title = tea.name
      subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    end
  end

  def update
    if params[:subscription_id].nil?
      render json: error('Subscription ID required')
    else
      subscription = Subscription.find(params[:subscription_id])
      if subscription.status == 'cancelled'
        render json: error('Subscription already cancelled')
      else
        subscription.update(status: 0)
        render json: SubscriptionSerializer.new(subscription)
      end
    end
  end

  private

  def subscription_params
    params.permit(:price, :frequency, :tea_id, :customer_id)
  end
end