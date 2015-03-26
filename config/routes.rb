Rails.application.routes.draw do
  namespace :api do
    resources :inbounds, only: [               :create                   ]

    resources :lists,    only: [:index, :show, :create, :update, :destroy] do
      member do
        get :add_member
      end
    end

    resources :members,  only: [:index, :show, :create, :update, :destroy]
  end
end
