Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :links
      resources :categories
      resources :sessions, only: [:destroy]
    end
  end

  root 'api/v1/home#index'
end
