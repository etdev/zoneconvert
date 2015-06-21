Rails.application.routes.draw do
  resources :events, only: [:new]
  # custom bootstrap styles test page
  get "bs_test" => "tests#show"

  root "events#new"
end
