Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  put "/users/:id/user_attributes", as: :user_attributes_update, to: "users#update_attributes"
  post "/users/:user_id/address", as: :user_address_create, to: "users#create_address"
  get "/offers", to: "offer#index"
end
