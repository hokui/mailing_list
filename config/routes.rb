Rails.application.routes.draw do
  namespace :api do
    resources :inbounds, only: :create
  end
end
