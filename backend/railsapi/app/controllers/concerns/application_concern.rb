module ApplicationConcern extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.credentials.secret_key_base
  SUCCESS_RESULT = {msg: "Success"}, 200

  def jwt_in_header
    authorization = request.headers[:authorization]
    return nil unless authorization
    split = authorization.split("Bearer ")
    return nil unless split[1].present?
    return split[1]
  end

  def id_in_jwt(jwt)
    begin
      payload = JWT.decode(jwt, SECRET_KEY, true, {algorithm: "HS256"})[0]
    rescue JWT::VerificationError, JWT::DecodeError, StandardError
      return nil
    end
    return payload["sub"]  # payload[:sub]はダメ 
  end

  def create_access_token(id)
    payload = {sub: id, exp: Time.now.to_i + 7*24*60*60}
    return JWT.encode(payload, SECRET_KEY, "HS256")
  end

  def register(email, password, name)
    if User.find_by(email: email)
      return {msg: "Email already taken"}, 409
    else
      User.create(email: email, pass_enc: Digest::SHA256.hexdigest(password), name: name)
      return SUCCESS_RESULT
    end
  end

  def authenticate(email, password)
    user = User.find_by(email: email)
    if user && Digest::SHA256.hexdigest(password) == user.pass_enc
      return {access_token: create_access_token(user.id)}, 200
    else
      return {msg: "Email or password incorrect"}, 401
    end
  end

  def update_email(current_val, new_val)
    if @user.email != current_val
      return {msg: "Current email incorrect"}, 400
    elsif User.find_by(email: new_val)
      return {msg: "New email already taken"}, 409
    else
      @user.email = new_val
      @user.save
      return SUCCESS_RESULT
    end
  end

  def update_password(current_val, new_val)
    if @user.pass_enc != Digest::SHA256.hexdigest(current_val)
      return {msg: "Current password incorrect"}, 400
    else
      @user.pass_enc = Digest::SHA256.hexdigest(new_val)
      @user.save
      return SUCCESS_RESULT
    end
  end

  def update_name(current_val, new_val)
    if @user.name != current_val
      return {msg: "Current name incorrect"}, 400
    else
      @user.name = new_val
      @user.save
      return SUCCESS_RESULT
    end
  end

end
