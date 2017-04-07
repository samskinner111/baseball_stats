Rails.application.routes.draw do
  get 'stats/index'

  resources :battings
  resources :players
  root 'stats#index'
end
