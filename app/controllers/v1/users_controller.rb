class V1::UsersController < ApplicationController

  def create
    user = User.new(
      user_name: params[:user_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation] 
    )
    if user.save
      render json: {status: "You have successly created a user"}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end
end
