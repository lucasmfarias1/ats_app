Rails.application.routes.draw do
  devise_for :users

  root to: "applicants#index"

  get '/:id', to: 'applicants#show', as: :applicant
  post '/applicants', to: 'applicants#create'
end
