Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :volunteers, only: [:index, :show]
      resources :campaigns, only: [:index, :show, :update, :create, :destroy]
    end
  end
end
