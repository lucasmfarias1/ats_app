Rails.application.routes.draw do
  devise_for :users
  root to: "applicants#index"

  get '/applicants', to: 'applicants#index', as: :applicants_path
  post '/applicants', to: 'applicants#create'
end
