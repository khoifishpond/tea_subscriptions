Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :teas, only: [:index]
      resources :subscriptions, only: [:index]
      post '/subscribe', to: 'subscriptions#create'
      patch '/unsubscribe', to: 'subscriptions#update'
    end
  end
end
