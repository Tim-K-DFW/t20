Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'proposals#homepage'
  resources :proposals
  post 'save', to: 'proposals#save'
  # get '/proposals/new', to: 'proposals#new'
  # post '/proposals', to: 'proposals#create'

end
