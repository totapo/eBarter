Rails.application.routes.draw do
  get 'welcome/index'
  resources :items
	resources :pessoas
  root 'welcome#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
