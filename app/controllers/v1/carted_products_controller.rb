class V1::CartedProductsController < ApplicationController

  def index
    # carted_product = CartedProduct.where("status ILIKE ? AND user_id = ?", "carted", current_user.id)
    carted_product = current_user.carted_products.where(status: "carted")
    render json: carted_product.as_json
  end

  def create
    carted_product = CartedProduct.new(
      user_id: current_user.id,
      product_id: params[:input_product_id],
      quantity: params[:input_quantity],
      status: "carted"
    ) 
    if carted_product.save
      render json: carted_product.as_json
    else
      render json: {errors: carted_product.errors.full_messages}, status: :bad_request
    end
  end

  def show
  end

  def update
  end
  
  def destroy 
    carted_product = CartedProduct.find_by(id: params[:id])
    carted_product.status = "removed"
    if carted_product.save
      render json: {message: "Product removed from cart"}
    end
  end
end
