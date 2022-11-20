# frozen_string_literal: true

Rails.application.routes.draw do
  resources :audit_templates
  post '/register', to: 'users#create'
  post '/login', to: 'users#login'
  # Routing logic: fallback requests for React Router.
  # Leave this here to help deploy your app later!
  get '*path', to: 'fallback#index', constraints: ->(req) { !req.xhr? && req.format.html? }
end
