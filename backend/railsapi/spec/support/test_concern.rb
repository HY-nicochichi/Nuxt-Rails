require "active_support/concern"

module TestConcern 
  extend ActiveSupport::Concern
 
  included do
    let!(:controller) {
      ApplicationController.new
    }

    let!(:test_password) {
      "Taro1234"
    }

    let!(:test_user) {
      User.create!(
        email: "taro@email.com", 
        pass_enc: User.encrypt_password(test_password), 
        name: "Taro"
      )
    }

    let!(:test_auth_header) {
      {"Authorization" => "Bearer " + controller.create_access_token(test_user.id)}
    }
  end
end
