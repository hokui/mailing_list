Rails.application.routes.draw do
  namespace :api do
    resources :inbounds, only: [               :create                   ]

    resources :lists,    only: [:index, :show, :create, :update, :destroy]

    resources :members,  only: [:index, :show, :create, :update, :destroy]
  end
end
