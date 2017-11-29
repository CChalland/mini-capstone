class V1::OrdersController < ApplicationController
  
  def create
    order = Order.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
    )
    order[:subtotal] = 100 * order[:quantity]
    order[:tax] = 0.09 * order[:subtotal]
    order[:total] = order[:subtotal] + order[:tax]

    if order.save
      render json: order.as_json
    else
      render json: {errors: order.errors.full_messages}, status: :bad_request
    end
  end
end
