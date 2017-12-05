class V1::OrdersController < ApplicationController
  before_action :authenticate_user

  def index
      orders = current_user.orders
      render json: orders.as_json
  end

  def create
    carted_products = CartedProduct.where({status: "carted", user_id: current_user.id})

    subtotal = 0
    carted_products.each do |carted_product|
      subtotal += carted_product.quantity * carted_product.product.price
    end

    tax = subtotal * 0.09
    total = subtotal + tax

    order = Order.new(
      user_id: current_user.id,
      subtotal: subtotal,
      tax: tax,
      total: total
    )
    if order.save
      carted_products.update_all(status: "purchased", order_id: order.id)
      render json: order.as_json
    else
      render json: {errors: order.errors.full_messages}, status: :bad_request
    end
  end
end
