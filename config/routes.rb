Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :main, only: [:index, :create]
  post '/' => "main#create", as: "root"
  root to: "main#index"
end
