Rails.application.routes.draw do
  get 'welcome/index'
  resources :items
	resources :pessoas
  root 'welcome#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'home', to: 'home#index'
  get 'edit_usuario', to: 'pessoas#edit'
  post 'edit_usuario', to: 'pessoas#update'
  post 'edit_item', to: 'items#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
