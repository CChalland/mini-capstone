class SuppliersController < ApplicationController
  def index
    supplier = Supplier.all.order(:id)
    if params[:search_name]
      supplier = supplier.where("name ILIKE ?", "%#{params[:search_name]}%")
    end
    render json: supplier.as_json
  end

  def create
    supplier = Supplier.new(
      name: params[:name],
      email: params[:email],
      phone_number: params[:phone_number]
      )
    if supplier.save
      render json: supplier.as_json
    else
      render json: {errors: supplier.errors.full_messages} status: :bad_request
    end
  end

  def show
    input = params[:id].to_i
    return_supplier = Supplier.find_by(id: input)
    render json: return_supplier.as_json
  end

  def update
    input = params[:id].to_i
    supplier = Supplier.find_by(id: input)
    supplier.name = params[:name]
    supplier.email = params[:email]
    supplier.phone_number = params[:phone_number]
    if supplier.save
      render json: supplier.as_json
    else
      render json: {errors: supplier.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    input = params[:id].to_i
    supplier = Supplier.find_by(id: input)
    supplier.destroy
    render json: {message: "You have deleted this supplier"}
  end
end
