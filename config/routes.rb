Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :events, only: [:new]
  # custom bootstrap styles test page
  get "bs_test" => "tests#show"
  get "about" => "static#about", as: :about
 
  root "events#new"
end
