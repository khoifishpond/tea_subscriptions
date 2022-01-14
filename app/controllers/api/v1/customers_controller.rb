class Api::V1::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    if Customer.exists?(params[:id])
      customer = Customer.find(params[:id])
      render json: CustomerSerializer.new(customer)
    else
      render json: error('Customer ID does not exist')
    end
  end
end