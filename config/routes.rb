Rails.application.routes.draw do
  devise_for :users

  root to: "applicants#index"

  get '/:id', to: 'applicants#show', as: :applicant
  put '/:id', to: 'applicants#update'
  get '/applicants', to: 'applicants#index', as: :applicants
  post '/applicants', to: 'applicants#create'
end
