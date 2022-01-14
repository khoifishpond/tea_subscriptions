class Api::V1::TeasController < ApplicationController
  def index
    render json: TeaSerializer.new(Tea.all)
  end

  def show
    if Tea.exists?(params[:id])
      tea = Tea.find(params[:id])
      render json: TeaSerializer.new(tea)
    else
      render json: error('Tea ID does not exist')
    end
  end
end