require "rails_helper"

RSpec.describe JwtController, type: :request do

  describe "POST #post" do
    it "Success" do
      post "/jwt/", params: {email: test_user.email, password: test_password}
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["msg"]).to eq("Success")
      access_token = JSON.parse(response.body)["access_token"]
      expect(access_token).to be_present
      id = JWT.decode(access_token, ApplicationConcern::SECRET_KEY, true, {algorithm: "HS256"})[0]["sub"]
      expect(id).to eq(test_user.id)
    end

    it "Failure: Email incorrect" do
      post "/jwt/", params: {email: "jiro@email.com", password: test_password}
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({"msg" => "Email or password incorrect"})
    end

    it "Failure: Password incorrect" do
      post "/jwt/", params: {email: test_user.email, password: "Jiro123"}
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({"msg" => "Email or password incorrect"})
    end
  end

end
