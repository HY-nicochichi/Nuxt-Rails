require "rails_helper"

RSpec.describe UserController, type: :request do

  describe "GET #get" do
    it "Success" do
      get "/user/", headers: test_auth_header
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq({"email" => test_user.email, "name" => test_user.name})
    end

    it "Failure: Invalid header" do
      get "/user/"
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq({"msg" => "'Authorization: Bearer Json.Web.Token' not in header"})
    end

    it "Failure: Invalid Json.Web.Token" do
      get "/user/", headers: {"Authorization" => "Bearer " + "hoge.hoge.hoge"}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq({"msg" => "Expired or invalid Json.Web.Token"})
    end

    it "Failure: Invalid User ID" do
      get "/user/", headers: {"Authorization" => "Bearer " + controller.create_access_token(0)}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq({"msg" => "User not found from Json.Web.Token"})
    end
  end

  describe "POST #post" do
    it "Success" do
      post "/user/", params: {email: "jiro@email.com", password: "Jiro1234", name: "Jiro"}
      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)).to eq({"msg" => "Success"})
    end

    it "Failure: Email conflict" do
      post "/user/", params: {email: test_user.email, password: "Jiro1234", name: "Jiro"}
      expect(response).to have_http_status(409)
      expect(JSON.parse(response.body)).to eq({"msg" => "Email already taken"})
    end
  end

  describe "PATCH #patch" do
    context "param email" do
      it "Success" do
        patch "/user/", params: {param: "email", current_val: test_user.email, new_val: "jiro@email.com"}, headers: test_auth_header
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"msg" => "Success"})
      end

      it "Failure: Current email incorrect" do
        patch "/user/", params: {param: "email", current_val: "jiro@email.com", new_val: "jiro@email.com"}, headers: test_auth_header
        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)).to eq({"msg" => "Invalid current value"})
      end
      it "Failure: New email conflict" do
        patch "/user/", params: {param: "email", current_val: test_user.email, new_val: test_user.email}, headers: test_auth_header
        expect(response).to have_http_status(409)
        expect(JSON.parse(response.body)).to eq({"msg" => "New value already taken"})
      end
    end

    context "param password" do
      it "Success" do
        patch "/user/", params: {param: "password", current_val: test_password, new_val: "Jiro1234"}, headers: test_auth_header
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"msg" => "Success"})
      end

      it "Failure: Current password incorrect" do
        patch "/user/", params: {param: "password", current_val: "Jiro1234", new_val: "Jiro1234"}, headers: test_auth_header
        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)).to eq({"msg" => "Invalid current value"})
      end     
    end

    context "param name" do
      it "Success" do
        patch "/user/", params: {param: "name", current_val: test_user.name, new_val: "Jiro"}, headers: test_auth_header
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"msg" => "Success"})
      end

      it "Failure: Current name incorrect" do
        patch "/user/", params: {param: "name", current_val: "Jiro", new_val: "Jiro"}, headers: test_auth_header
        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)).to eq({"msg" => "Invalid current value"})
      end     
    end
  end

  describe "DELETE #delete" do
    it "Success" do
      delete "/user/", headers: test_auth_header
      expect(response).to have_http_status(204)
      expect(response.body).to eq("")
    end
  end

end
