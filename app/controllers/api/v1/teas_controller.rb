class Api::V1::TeasController < ApplicationController
  def index
    render json: TeaSerializer.new(Tea.all)
  end

  def show
    if params[:tea_id].nil?
      render json: error('Tea ID required')
    else
      tea = Tea.find(params[:tea_id])
      render json: TeaSerializer.new(tea)
    end
  end
end