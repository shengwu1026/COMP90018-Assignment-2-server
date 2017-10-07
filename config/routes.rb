Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
      resources :users
      resources :buildings
      resources :lots do
          get '/little_brother_chips', to: 'lots#fetch_little_brother_chips'
      end
      resources :beacons
      resources :locations
      resources :little_brother_chips do
          get '/location', to: 'locations#fetch'
          patch '/location', to: 'locations#triangulate'
      end
  end

  root 'static#index'
end

{
	"beacons": [{
		"major": 63689,
		"uuid": "b9407f30-f5f8-466e-aff9-25556b57fe6d",
        "minor":23053,
        "rssi": -55
	}, {
		"major": 54350,
		"uuid": "b9407f30-f5f8-466e-aff9-25556b57fe6d",
        "minor": 21775,
		"rssi": -81
	}, {
		"major": 22175,
		"uuid": "b9407f30-f5f8-466e-aff9-25556b57fe6d",
		"minor": 6525,
		"rssi": -83
	}]
}
