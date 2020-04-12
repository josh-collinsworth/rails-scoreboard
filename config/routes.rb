Rails.application.routes.draw do
  root to: 'game#index'

  resources :game

  namespace :api do
    resources :games
    resources :participants
    resources :game_participants
  end
end
