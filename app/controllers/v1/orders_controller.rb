class V1::OrdersController < ApplicationController

  def create
    order = Order.new(
      product_id: params[:product_id],
      quantity: params[:quantity]
    )
    if order.save
      render json: order.as_json
    else
      render json: {errors: order.errors.full.messages}, status: :bad_request
    end
  end
end
