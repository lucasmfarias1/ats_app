Rails.application.routes.draw do
  devise_for :users
  root to: "guesses#show"
  post '/', to: 'guesses#create'
  get '/reset', to: 'guesses#reset', as: :reset
end
