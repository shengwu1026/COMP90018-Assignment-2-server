Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
      resource :users
      resource :little_brother_chips
      resource :buildings
      resource :lots
      resource :beacons
      resource :locations
  end  
end
