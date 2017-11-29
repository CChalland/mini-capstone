class V1::UserTokenController < Knock::AuthTokenController
  # before_action :authenticate_user
  # if current_user
  #   products = current_user.products
  #   render json: products.as_json
  # else
  #   render json: []
end
