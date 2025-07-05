require "rails_helper"

RSpec.describe JwtController, type: :request do

  describe "POST #post" do
    it "Success" do
      post "/jwt/", params: {email: test_user.email, password: test_password}
      expect(response).to have_http_status(200)
      access_token = JSON.parse(response.body)["access_token"]
      expect(access_token).to be_present
      user_id = controller.user_id_in_token(access_token)
      expect(user_id).to eq(test_user.id)
    end

    it "Failure: Params validation failed" do
      post "/jwt/", params: {email: "invalid_email", password: "invalid_password"}
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["msg"]).to eq("Validation failed")
    end

    it "Failure: Email incorrect" do
      post "/jwt/", params: {email: "jiro@email.com", password: test_password}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq({"msg" => "Email or password incorrect"})
    end

    it "Failure: Password incorrect" do
      post "/jwt/", params: {email: test_user.email, password: "Jiro1234"}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq({"msg" => "Email or password incorrect"})
    end
  end

end
