class V1::OrdersController < ApplicationController

  def index
    order = Order.all.order(:id)
    if current_user
      order = current_user.orders
      render json: order.as_json
    else
      render json: []
    end
  end

  def create
    order = Order.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity]
    )
    product = Product.find_by(id: order[:product_id])
    order[:subtotal] = product.price * order[:quantity]
    order[:tax] = 0.09 * order[:subtotal]
    order[:total] = order[:subtotal] + order[:tax]

    if order.save
      render json: order.as_json
    else
      render json: {errors: order.errors.full_messages}, status: :bad_request
    end
  end
end
