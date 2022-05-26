Rails.application.routes.draw do
  #管理者用
  namespace :admin do
    root to: 'homes#top'
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index,:edit,:create,:update]
    resources :items, only: [:new,:index,:show,:edit,:update,:destroy]
    post "items/new" => "items#create"
    resources :orders, only: [:show, :update]  
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

    resources :items, only: [:index, :show]

  devise_for :end_users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }


    delete '/cart_items/destroy_all' => "cart_items#destroy_all"
    post '/orders/confirm' => "orders#confirm"
    get '/orders/thanks' => "orders#thanks", as: "thanks"
    resources :orders, only: [:index, :create, :show, :new]
    resources :cart_items, only: [:index, :create, :update, :destroy]


    end

    scope module: :public do
    resources :shipping_addresses, only: [:index, :create, :edit, :update, :destroy]

    end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
