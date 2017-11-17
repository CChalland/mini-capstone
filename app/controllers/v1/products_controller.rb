class V1::ProductsController < ApplicationController
  def all_products_info_method
    all = Product.all 
    render json: all.as_json
  end

  def skates_method
    skates = Product.first
    render json: skates.as_json
  end

  def shins_method
    shins = Product.second
    render json: shins.as_json
  end

  def pants_method
    pants = Product.third
    render json: pants.as_json
  end

  def sholders_method
    sholders = Product.fourth
    render json: sholders.as_json
  end

  def elbows_method
    elbows = Product.fifth
    render json: elbows.as_json
  end

  def gloves_method
    gloves = Product.last
    render json: gloves.as_json
  end

  def product_method
    input = params["input_product"].to_i
    return_product = Product.find_by(id: input)
    render json: {product: return_product.as_json}
  end
  #   input = params["input_product"]
  #   if input == "skates"
  #     return_product = Product.first
  #   elsif input == "shins"
  #     return_product = Product.second
  #   elsif input == "pants"
  #     return_product = Product.third
  #   elsif input == "sholders"
  #     return_product = Product.fourth
  #   elsif input == "elbows"
  #     return_product = Product.fifth
  #   elsif input == "gloves"
  #     return_product = Product.last
  #   end
  # render json: {product: return_product.as_json}
  # end

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