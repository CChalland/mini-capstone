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
      url1: params[:url1],
      url2: params[:url2],
      url3: params[:url3]
      )
    if image.save
      render json: image.as_json
    else
      render json: {errors: image.errors.full_messages}, status: :bad_request
    end
  end

  def show
    input = params[:id].to_i
    return_image = Image.find_by(id: input)
    render json: return_image.as_json
  end

  def update
    input = params[:id].to_i
    image = Image.find_by(id: input)
    image.url1 = params[:url1]
    image.url2 = params[:url2]
    image.url3 = params[:url3]
    if image.save
      render json: image.as_json
    else
      render json: {errors: image.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    input = params[:id].to_i
    image = Image.find_by(id: input)
    image.destroy
    render json: {message: "You have deleted this image"}
  end
end
