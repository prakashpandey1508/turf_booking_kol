Rails.application.routes.draw do
   root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    resources :turfs, except: [:new, :edit], defaults: { format: :json }
    resources :bookings, except: [:new, :edit], defaults: { format: :json }
    resources :users, defaults: { format: :json } do
      collection do
        put 'sign_up', to: 'users#sign_up'
        put 'sign_in', to: 'users#sign_in'
      end
      put 'update_profile', to: 'users#update_profile'
    end
  end
end
