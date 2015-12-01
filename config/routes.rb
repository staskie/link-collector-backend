Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :links, except: [:show, :edit]
      resources :categories, only: [:index] do
        resources :links, only: [:index], controller: 'category_links'
      end
      resources :sessions, only: [:create]
    end
  end
end
