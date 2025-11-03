Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/"

  post   "/jwt/"  => "jwt#post"

  get    "/user/" => "user#get"
  post   "/user/" => "user#post"
  patch  "/user/" => "user#patch"
  delete "/user/" => "user#delete"
end
