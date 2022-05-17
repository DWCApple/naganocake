Rails.application.routes.draw do
  namespace :public do
    get 'cart_items/index'
    get 'cart_items/create'
    get 'cart_items/update'
    get 'cart_items/destroy'
    get 'cart_items/destroy_all'
  end
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
  
    namespace :public do
    get 'orders/about'
    get 'orders/compleate'
    get 'orders/index'
    get 'orders/new'
    get 'orders/show'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
