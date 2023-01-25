Rails.application.routes.draw do
  devise_for :users

  root to: "applicants#index"

  get '/:id', to: 'applicants#show', as: :applicant
  put '/:id', to: 'applicants#update'
  get '/applicants', to: 'applicants#index', as: :applicants
  post '/applicants', to: 'applicants#create'

  post '/applicants/:applicant_id/notes', to: 'notes#create', as: :notes
  delete '/applicants/:applicant_id/notes/:id', to: 'notes#destroy', as: :note

  post '/applicants/:applicant_id/attachments', to: 'attachments#create', as: :attachments
end
