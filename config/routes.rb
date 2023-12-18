Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        get '/weather', to: 'weather#show'
      end
    end
  end
end
