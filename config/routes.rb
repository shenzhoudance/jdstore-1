Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/foo/:a/:b/:c" => "welcome#index", :as => "foobar"

  resources :orders do
    post :foo
    collection do
      get :bar
    end

    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
  end

  resource :cart do
    collection do
      post :clean
      post :checkout
    end
  end

  resources :cart_items

  resources :products do
    member do
      post :add_to_cart
    end
  end

  # scope :module => "admin", :as => "admin", :path => "admin" do
  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  root "products#index"

end
