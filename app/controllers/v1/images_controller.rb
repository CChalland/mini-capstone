class V1::ImagesController < ApplicationController
   def index
    image = Image.all.order(:id)
    if params[:search_url]
      image = image.where(" url1 ILIKE ?", "%#{params[:search_url]}%")
    end
    render json: image.as_json
  end

  def create
    image = Image.new(
      url: params[:url],
      product_id: params[:product_id]
    )
    if image.save
      render json: image.as_json
    else
      render json: {errors: image.errors.full_messages}, status: :bad_request
    end
  end

  def show
    return_image = Image.find_by(id: params[:id].to_i)
    render json: return_image.as_json
  end

  def update
    image = Image.find_by(id: params[:id].to_i)
    image.url = params[:url]
    image.product_id = params[:product_id]
    if image.save
      render json: image.as_json
    else
      render json: {errors: image.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    image = Image.find_by(id: params[:id].to_i)
    image.destroy
    render json: {message: "You have deleted this image"}
  end
end
