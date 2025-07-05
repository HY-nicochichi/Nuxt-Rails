require "active_support/concern"

module TestConcern extend ActiveSupport::Concern

  include ApplicationConcern
  
  included do
    let!(:test_password) {
      return "Taro123"
    }

    let!(:test_user) {
      return User.create!(
        email: "taro@email.com", 
        pass_enc: Digest::SHA256.hexdigest(test_password), 
        name: "Taro"
      )
    }

    let!(:test_auth_header) {
      return {"Authorization" => "Bearer " + create_access_token(test_user.id)}
    }
  end

end
