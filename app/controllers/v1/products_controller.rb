class V1::ProductsController < ApplicationController
  before_action :authenticate_admin, except: [:index, :show]

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
      price: params[:price].to_f,
      description: params[:description],
      supplier_id: params[:supplier_id].to_i,
      availability: true
    )
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :bad_request
    end
  end

  def show
    return_product = Product.find_by(id: params[:id].to_i)
    render json: return_product.as_json
  end

  def update
    product = Product.find_by(id: params[:id].to_i)
    product.name = params[:name]
    product.price = params[:price]
    product.description = params[:description]
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    product = Product.find_by(id: params[:id].to_i)
    product.destroy
    render json: {message: "You have deleted this item"}
  end
end
