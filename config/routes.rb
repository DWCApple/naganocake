Rails.application.routes.draw do

  namespace :admin do
    resources :genres, only:[:index,:edit,:create,:update]
    resources :items, only:[:new,:index,:show,:edit,:update,:destroy]
    post "items/new" => "items#create"
  end

  #管理者用
  namespace :admin do
    root to: 'homes#top'
  end

  #URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #顧客用
  #URL /end_users/sign_in ...
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about", as: "about"
    resource :end_users, only: [:edit, :show, :update]
    # 退会確認画面
    get '/end_users/:id/unsubscribe' => 'end_users#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/end_users/:id/withdrawal' => 'end_users#withdrawal', as: 'withdrawal'
  end

  scope module: :public do
    resources :items, only: [:index, :show]
  end

  devise_for :end_users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

<<<<<<< HEAD
  scope module: :public do
    delete '/cart_items/destroy_all' => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :create, :update, :destroy]
=======

    namespace :public do
>>>>>>> acf018e0e83e72138a21945bf7cb377b81bd7b93
    get 'orders/about'
    get 'orders/compleate'
    get 'orders/index'
    get 'orders/new'
    get 'orders/show'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
