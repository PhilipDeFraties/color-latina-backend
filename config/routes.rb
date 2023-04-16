Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :volunteers
      resources :campaigns do
        resources :messages do
          # post :send_to_campaign_volunteers, on: :collection
          match 'send_to_campaign_volunteers', via: %i[post], as: :send_to_campaign_volunteers, on: :collection
        end
      end
    end
  end
end
