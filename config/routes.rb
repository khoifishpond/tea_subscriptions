Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :teas, only: [:index]
      get '/tea', to: 'teas#show'
      resources :customers, only: [:index]
      get '/customer', to: 'customers#show'
      resources :subscriptions, only: [:index]
      get '/subscription', to: 'subscriptions#show'
      post '/subscribe', to: 'subscriptions#create'
      patch '/unsubscribe', to: 'subscriptions#update'
    end
  end
end
