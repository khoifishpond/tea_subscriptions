class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    if Customer.exists?(params[:id])
      customer = Customer.find(params[:id])
      render json: SubscriptionSerializer.new(customer.subscriptions)
    else
      render json: error('Customer does not exist')
    end
  end

  def show
    if Customer.exists?(params[:id]) && Subscription.exists?(params[:subscription_id])
      subscription = Subscription.find(params[:subscription_id])
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: error('Customer or Subscription does not exist')
    end
  end
  
  def create
    if Customer.exists?(params[:id]) && Tea.exists?(params[:tea_id])
      customer = Customer.find(params[:id])
      tea = Tea.find(params[:tea_id])

      subscription = Subscription.create(subscription_params)
      subscription.title = "#{tea.name} Subscription"
      subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: error('Customer or Tea ID does not exist')
    end
  end

  def update
    if Subscription.exists?(params[:subscription_id])
      subscription = Subscription.find(params[:subscription_id])
      if subscription.status == 'cancelled'
        render json: error('Subscription already cancelled')
      else
        subscription.update(status: 0)
        render json: SubscriptionSerializer.new(subscription)
      end
    else
      render json: error('Subscription does not exist')
    end
  end

  private

  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end