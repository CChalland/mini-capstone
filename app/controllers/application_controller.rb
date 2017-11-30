class ApplicationController < ActionController::API
  include Knock::Authenticable

  def authenticate_admin
    unless current_user && current_user.admin
      render json: {errors: "Not authorized!"}, status: :unauthorized 
    end
  end

  def authenticate_user
    unless current_user
      render json: {errors: "You're not logged in!"}, status: :unauthorized
    end
  end
end
