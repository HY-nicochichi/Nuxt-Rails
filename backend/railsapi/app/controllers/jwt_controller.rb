class JwtController < ApplicationController

  def post
    json, status = authenticate(params[:email], params[:password])
    return render json: json, status: status
  end

end
