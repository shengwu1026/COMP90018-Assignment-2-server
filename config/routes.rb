Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
      resources :users
      resources :buildings
      resources :lots
      resources :beacons
      resources :locations
      resources :little_brother_chips do
          get '/location', to: 'locations#fetch'
          patch '/triangulate', to: 'locations#triangulate' #, as: :locations_triangulate
      end
  end

  root 'static#index'
end
