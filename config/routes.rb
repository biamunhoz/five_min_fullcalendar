Rails.application.routes.draw do
  resources :salas
  resources :agendas
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'events#index'
  
end
