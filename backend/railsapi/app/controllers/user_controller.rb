class UserController < ApplicationController
  before_action :jwt_protect, except: [:post]

  validate_params_with UserSchema::Post, action: :post
  validate_params_with UserSchema::Patch, action: :patch

  def get
    render json: {email: @current_user.email, name: @current_user.name}, status: 200
  end

  def post
    if User.find_by(email: @valid_data[:email])
      return render json: {msg: "Email already taken"}, status: 409
    end
    ActiveRecord::Base.transaction do
      User.create!(
        email: @valid_data[:email],
        pass_enc: User.encrypt_password(@valid_data[:password]),
        name: @valid_data[:name]
      )
    end
    render json: {msg: "Success"}, status: 201
  end

  def patch
    current_val = @valid_data[:current_val]
    new_val = @valid_data[:new_val]
    case @valid_data[:param]
    when "email"
      if @current_user.email != current_val
        return render json: {msg: "Invalid current value"}, status: 400
      elsif User.find_by(email: @valid_data[:new_val])
        return render json: {msg: "New value already taken"}, status: 409
      end
      @current_user.email = new_val
    when "password"
      if !@current_user.password_matched?(current_val)
        return render json: {msg: "Invalid current value"}, status: 400
      end
      @current_user.pass_enc = User.encrypt_password(new_val)
    when "name"
      if @current_user.name != current_val
        return render json: {msg: "Invalid current value"}, status: 400
      end
      @current_user.name = new_val
    end
    ActiveRecord::Base.transaction do
      @current_user.save!
    end
    render json: {msg: "Success"}, status: 200
  end

  def delete
    ActiveRecord::Base.transaction do
      @current_user.destroy!
    end
    render plain: "", status: 204
  end
end
