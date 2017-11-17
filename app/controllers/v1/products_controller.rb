class V1::ProductsController < ApplicationController
  def index
    product = Product.all
    render json: product.as_json
  end

  def show
    input = params["id"].to_i
    return_product = Product.find_by(id: input)
    render json: return_product.as_json
  end
end