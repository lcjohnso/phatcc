Rails.application.routes.draw do
  resources :bricks, only: [:index, :show] do
    member do
      get 'usersort'
      get 'sort'
    end
    resources :clusters
  end

  resources :clusters, only: [:show, :update] do
    member do
      get 'sashow'
      get 'sushow'
    end
    resources :comments
    resources :ratings
  end

  resources :apbricks, only: [:index, :show] do
    member do
      get 'csort'
      get 'gsort'
    end
    resources :apobjects
  end

  resources :apobjects, only: :show do
    member do
      get 'cshow'
      get 'gshow'
    end
  end

  #resource "user" do
  #  member do
  #    get "process_login"
  #    get "login"
  #    get "logout"
  #  end
  #end

  #get 'user/:action', controller: 'user'
  #resource :user, only: ['login', 'logout', 'my_account', 'process_login']
  get 'user/login', to: 'user#login'
  get 'user/logout', to: 'user#logout'
  get 'user/index', to: 'user#index'
  post 'user/process_login', to: 'user#process_login'

  get 'login', to: 'user#login'
  get 'logout', to: 'user#logout'

  #get 'welcome/index'
  #root 'welcome#index'
  get 'home/index'
  root 'home#index'
end
