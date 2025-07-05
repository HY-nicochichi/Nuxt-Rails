class JwtController < ApplicationController
  validate_params_with JwtSchema::Post, action: :post

  def post
    user = User.find_by(email: @valid_data[:email])
    if user && user.password_matched?(@valid_data[:password])
      render json: {access_token: create_access_token(user.id)}, status: 200
    else
      render json: {msg: "Email or password incorrect"}, status: 401
    end
  end
end
