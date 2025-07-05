module UserSchema
  class Post < ApplicationSchema
    params do
      required(:email).filled(:string)
      required(:password).filled(:string)
      required(:name).filled(:string)
    end

    rule(:email).validate(:validate_email)
    rule(:password).validate(:validate_password)
    rule(:name).validate(:validate_name)
  end

  class Patch < ApplicationSchema
    params do
      required(:param).filled(:string, included_in?: %w[email password name])
      required(:current_val).filled(:string, size?: 1..50)
      required(:new_val).filled(:string, size?: 1..50)
    end
  end
end
