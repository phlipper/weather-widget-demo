Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :locations, only: %i[index show new create]

  # Defines the root path route ("/")
  root "locations#index"
end
