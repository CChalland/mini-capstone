class V1::ProductsController < ApplicationController
  def index
    product = Product.all.order(:id)
    if params[:search_name]
      product = product.where("name ILIKE ?", "%#{params[:search_name]}%")
    elsif params[:search_price]
      product = Product.order(price: :desc)
    end
    render json: product.as_json
  end

  def create
    product = Product.new(
      name: params[:name], 
      price: params[:price], 
      image: params[:image], 
      description: params[:description]
    )
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :bad_request
    end
  end

  def show
    input = params["id"].to_i
    return_product = Product.find_by(id: input)
    render json: return_product.as_json
  end

  def update
    input = params[:id].to_i
    product = Product.find_by(id: input)
    product.name = params[:name]
    product.price = params[:price]
    product.image = params[:image]
    product.description = params[:description]
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    input = params[:id].to_i
    product = Product.find_by(id: input)
    product.destroy
    render json: {message: "You have deleted this item"}
  end
end