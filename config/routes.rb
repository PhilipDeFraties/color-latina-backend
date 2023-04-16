Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :volunteers
      resources :campaigns do
        resources :messages do
          post :send_to_campaign_volunteers, on: :collection
        end
      end
    end
  end
end
