Tree::Application.routes.draw do
  get 'signin' => 'sessions#create'

  resources :projects, only: [:show,:index,:new,:create]
  resources :articles, only: [:show,:index,:new,:create,:update]
  resources :relations, only: :create
  root :to => 'projects#index'
end
