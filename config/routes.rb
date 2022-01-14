Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :teas, only: [:index, :show]
      resources :customers, only: [:index, :show]
      get 'customers/:id/subscriptions', to: 'customers/subscriptions#index'
      get 'customers/:id/subscriptions/:subscription_id', to: 'customers/subscriptions#show'
      post 'customers/:id/subscriptions/:tea_id', to: 'customers/subscriptions#create'
      patch 'customers/:id/subscriptions/:subscription_id', to: 'customers/subscriptions#update'
    end
  end
end
