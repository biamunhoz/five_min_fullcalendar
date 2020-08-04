Rails.application.routes.draw do
  
  #get 'welcome/login'
  get 'welcome/login', as: 'login'
  get 'welcome/callback'
  
  resources :perfils
  resources :tipo_vinculos
  resources :usuarios
  resources :salas
  resources :agendas
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #root 'events#index'

  get 'logout' => 'welcome#destroy', as: 'logout'

  get 'inscricao/:id' => 'agendas#inscricao', as: 'inscricao'

  get 'versalas/:id' => 'salas#versalas', as: 'versalas'

  root 'welcome#login'

  
end
