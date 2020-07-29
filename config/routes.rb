# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: "",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               registration: "signup"
             },
             controllers: {
               confirmations: "confirmations",
               sessions: "sessions",
               registrations: "registrations",
               passwords: "passwords"
             }
  devise_scope :user do
    post "/invite-admin", to: "registrations#create_admin"
    get "/invite-admin", to: "registrations#verify_admin_token"
    put "/signup/admin", to: "registrations#register_admin"
  end
  get "hello/index"
  root "home#index"
  namespace :v1, defaults: { format: "json" } do
    get "things", to: "things#index"
    get "taks/index"
    resources :sheikhs do
      collection do
        get "search"
      end
    end
  end

  # Forward all requests to StaticController#index but requests
  # must be non-Ajax (!req.xhr?) and HTML Mime type (req.format.html?).
  # This does not include the root ("/") path.
  get "*page", to: "single_page#index", constraints: ->(req) do
    !req.xhr? && req.format.html?
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
