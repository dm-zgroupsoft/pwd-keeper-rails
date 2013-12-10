PwdKeeperRails::Application.routes.draw do
  devise_for :users
  resources :groups do
    resources :entries
    member do
      patch :move
    end
  end
  root :to => 'groups#index'
end
