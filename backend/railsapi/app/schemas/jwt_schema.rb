module JwtSchema
  class Post < ApplicationSchema
    params do
      required(:email).filled(:string)
      required(:password).filled(:string)
    end

    rule(:email).validate(:validate_email)
    rule(:password).validate(:validate_password)
  end
end
