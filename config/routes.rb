Rails.application.routes.draw do
  resources :payments, only: [:create, :new]
  resources :admins
  get 'sign_up', to: "sign_up#new"
  post 'sign_up', to: "sign_up#create"
  get 'login', to: "login#new"
  post 'login', to: "login#create"
  delete 'logout', to: "login#destroy"
  get 'admin/login', to: "login#admin_login"
  post 'admin/login', to: "login#create_admin_session"
  delete 'admin/logout', to: "login#destroy_admin_session"
  
  resources :orders do
    resources :order_items, only: [:update, :destroy] do
      collection do
        patch "update_all"
      end  
    end  
    
    collection do
      post :create_order_items
    end
  end
  
  resources :customers
  resources :orderings, only: [:index] do
    collection do
      post "order"
      get "checkout"
      post "update_order_items"
    end
    member do
      put "increment_quantity"
      delete "decrement_quantity"
    end
  end  
  resources :menu_items
  resources :categories
  
  namespace :api do
    resources :menu_items
    resources :orders
  end
  
  root to: 'orderings#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
