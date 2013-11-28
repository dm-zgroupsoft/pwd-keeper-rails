PwdKeeperRails::Application.routes.draw do
  devise_for :users
  resources :groups do
    resources :entries
  end
  root :to => 'groups#index'
end
