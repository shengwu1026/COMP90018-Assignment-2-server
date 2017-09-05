Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/rspec-output.html' => '/public/rspec-output.html'
end
