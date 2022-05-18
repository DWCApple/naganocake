Rails.application.routes.draw do
  #管理者用
  #URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #顧客用
  #URL /end_users/sign_in ...
  devise_for :end_users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    delete '/cart_items/destroy_all' => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :create, :update, :destroy]
    get 'orders/about'
    get 'orders/compleate'
    get 'orders/index'
    get 'orders/new'
    get 'orders/show'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
