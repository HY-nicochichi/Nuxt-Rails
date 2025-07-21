class UserController < ApplicationController

  before_action :current_user, except: [:post]

  def get
    return render json: {email: @user.email, name: @user.name}, status: 200
  end

  def post
    json, status = register(params[:email], params[:password], params[:name])
    return render json: json, status: status
  end

  def put
    param = params[:param]
    current_val = params[:current_val]
    new_val = params[:new_val]
    if param == "email"
      json, status = update_email(current_val, new_val)   
    elsif param == "password"
      json, status = update_password(current_val, new_val)  
    elsif param == "name"
      json, status = update_name(current_val, new_val)
    else
      json, status = {msg: "Param incorrect"}, 400
    end
    return render json: json, status: status
  end

  def delete
    @user.destroy
    json, status = SUCCESS_RESULT
    return render json: json, status: status
  end

end
