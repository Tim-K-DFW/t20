Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'proposals#homepage'
  get '/new', to: 'proposals#new'

end
