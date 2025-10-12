module ApplicationConcern extend ActiveSupport::Concern
  SUCCESS_RESULT = {msg: "Success"}, 200

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
      return {msg: "Success", access_token: create_access_token(user.id)}, 200
    else
      return {msg: "Email or password incorrect"}, 401
    end
  end

  def update_email(current_val, new_val)
    if @current_user.email != current_val
      return {msg: "Current email incorrect"}, 400
    elsif User.find_by(email: new_val)
      return {msg: "New email already taken"}, 409
    else
      @current_user.email = new_val
      @current_user.save
      return SUCCESS_RESULT
    end
  end

  def update_password(current_val, new_val)
    if @current_user.pass_enc != Digest::SHA256.hexdigest(current_val)
      return {msg: "Current password incorrect"}, 400
    else
      @current_user.pass_enc = Digest::SHA256.hexdigest(new_val)
      @current_user.save
      return SUCCESS_RESULT
    end
  end

  def update_name(current_val, new_val)
    if @current_user.name != current_val
      return {msg: "Current name incorrect"}, 400
    else
      @current_user.name = new_val
      @current_user.save
      return SUCCESS_RESULT
    end
  end
end
