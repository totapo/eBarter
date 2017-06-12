Rails.application.routes.draw do
  get 'welcome/index'
  resources :items
	resources :pessoas
  resources :propostas
  root 'welcome#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#logout'
  get 'home', to: 'home#index'
  get 'edit_usuario', to: 'pessoas#edit'
  post 'edit_usuario', to: 'pessoas#update'
  post 'edit_item', to: 'items#update'
  post 'pesquisar', to: 'home#pesquisar'
  post 'nova_proposta', to:'items#nova_proposta'
  post 'ofertar_item_proposta', to: 'propostas#ofertar'
  post 'adicionar_item_proposta', to: 'propostas#adicionar_item'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
