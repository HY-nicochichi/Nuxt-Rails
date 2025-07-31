Rails::Jwt::Lite.configure do |config|
  config.jwt_secret_key = "JWT_SECRET_KEY"
  config.jwt_expires = 7.day
  config.user_loader = Proc.new do |user_id|
    User.find_by(id: user_id)
  end
end
