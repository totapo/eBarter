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
  get 'pesquisar', to: 'home#pesquisar'
  post 'nova_proposta', to:'items#nova_proposta'
  post 'ofertar_item_proposta', to: 'propostas#ofertar'
  post 'adicionar_item_proposta', to: 'propostas#adicionar_item'
  post 'remover_item_proposta', to: 'propostas#remover_item'
  post 'alterar_quantidade_item_proposta', to:'propostas#alterar_quantidade_ofertado'
  post 'adicionar_item_demandado_proposta', to: 'propostas#adicionar_item_demandado'
  post 'remover_item_demandado_proposta', to: 'propostas#remover_item_demandado'
  post 'alterar_quantidade_item_demandado_proposta', to:'propostas#alterar_quantidade_demandado'
  get 'trocas', to:'trocas#show'
  get 'avaliar_troca', to:'avaliacoes#avaliar'
  get 'confirmar_troca', to:'trocas#confirmar'
  get 'cancelar_troca', to:'trocas#cancelar'
  get 'aceitar_proposta', to:'propostas#aceitar_proposta'
  get 'cancelar_proposta', to: 'propostas#cancelar_proposta'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
