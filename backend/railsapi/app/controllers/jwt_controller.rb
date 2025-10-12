class JwtController < ApplicationController
  def post
    json, status = authenticate(@valid_data[:email], @valid_data[:password])
    return render json: json, status: status
  end

  validate_params_with JwtPostSchema, action: :post
end
