Rails.application.routes.draw do
  
  #login e logout
  get 'welcome/login', as: 'login'
  get 'welcome/callback'
  get 'logout' => 'welcome#destroy', as: 'logout'
  
  resources :perfils
  resources :tipo_vinculos
  resources :usuarios
  resources :salas
  resources :agendas
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #inscricao e permissao
  get 'inscricao/:id' => 'agendas#inscricao', as: 'inscricao'
  get 'versalas/:id' => 'salas#versalas', as: 'versalas'
  get 'permissao/:id' => 'salas#permissao', as: 'permissao'

  get 'addadmin/:id/sala=:sala' => 'salas#addadmin', as: 'addadmin'
  get 'altersuper/:id/sala=:sala' => 'salas#altersuper', as: 'altersuper'
  get 'altersimples/:id/sala=:sala' => 'salas#altersimples', as: 'altersimples'

  get 'listagem' => 'events#listagem', as: 'listagem'
  #get 'eventoagenda/:id' => 'events#eventoagenda', as: 'eventoagenda'

  get 'eventoagenda/:id', to: 'events#eventoagenda', as: 'eventoagenda'
  get 'resultagenda', to: 'events#resultagenda', as: 'resultagenda', defaults: { format: :json }

  get 'agendamentos/:id' => 'events#agendamentos', as: 'agendamentos'
  get 'deleteagend/:id' => 'events#deleteagend', as: 'deleteagend'

  root 'welcome#login'

  
end
