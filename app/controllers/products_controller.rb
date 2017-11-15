class ProductsController < ApplicationController
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
end

