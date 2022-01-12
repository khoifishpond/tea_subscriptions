class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    if params[:customer_id].nil?
      render json: error('Customer ID required')
    else
      customer = Customer.find(params[:customer_id])
      render json: CustomerSerializer.new(customer)
    end
  end
end