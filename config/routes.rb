Rails.application.routes.draw do
  resources :events, only: [:new]
  root "events#new"
end
