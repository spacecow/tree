Tree::Application.routes.draw do
  get 'signin' => 'sessions#create'
  get 'signout' => 'sessions#destroy'

  resources :projects, only: [:show,:index,:new,:create]

  resources :articles, only: [:show,:index,:new,:create,:edit,:update,:delete] do
    resources :relations, only: [:show,:create,:destroy]
    collection do
      get :test
    end
  end

  resources :characters, controller: :articles
  #  resources :relations
  #end
  #resources :events, controller: :articles do
  #  resources :relations
  #end

  resources :histories, only:[:create,:edit,:update]

  get 'welcome' => 'projects#index'
  root :to => 'projects#index'
end
