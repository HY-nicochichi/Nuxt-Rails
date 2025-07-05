class ApplicationController < ActionController::API

  include ApplicationConcern

  def current_user
    jwt = jwt_in_header
    return render json: {msg: "'Authorzation: Bearer Json.Web.Token' not in header"}, status: 401 unless jwt
    id = id_in_jwt(jwt)
    return render json: {msg: "Expired or invalid Json.Web.Token"}, status: 401 unless id
    @user = User.find_by(id: id)
    return render json: {msg: "User not found from Json.Web.Token"}, status: 401 unless @user
  end

end
