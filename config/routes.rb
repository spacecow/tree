Tree::Application.routes.draw do
  resources :projects, only: :new
  root :to => 'projects#index'
end
