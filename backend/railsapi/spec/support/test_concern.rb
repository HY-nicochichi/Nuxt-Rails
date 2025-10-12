require "active_support/concern"

module TestConcern extend ActiveSupport::Concern
 
  included do
    let!(:controller) {
      return ApplicationController.new
    }

    let!(:test_password) {
      return "Taro1234"
    }

    let!(:test_user) {
      return User.create!(
        email: "taro@email.com", 
        pass_enc: Digest::SHA256.hexdigest(test_password), 
        name: "Taro"
      )
    }

    let!(:test_auth_header) {
      return {"Authorization" => "Bearer " + controller.create_access_token(test_user.id)}
    }
  end

end
