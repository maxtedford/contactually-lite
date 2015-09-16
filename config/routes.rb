Rails.application.routes.draw do
  root "welcome#show"
  
  resources :contacts, only: [:index, :create, :destroy]
end
