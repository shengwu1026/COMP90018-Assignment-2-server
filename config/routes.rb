Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
      resources :users
      resources :little_brother_chips
      resources :buildings
      resources :lots
      resources :beacons
      resources :locations
  end

  root 'static#index'
end
