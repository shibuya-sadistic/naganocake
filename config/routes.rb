Rails.application.routes.draw do

  devise_for :admins, controllers: {
        sessions: 'admins/sessions'
  }
  devise_for :customers, controllers: { registrations: 'registrations' }

  # customers routes
  root to: 'home#top'
  get "/about" => "home#about", as: "about"
  resources :products, only: [:index, :show]
  resources :cart_items, only:[:create, :index, :update, :destroy]
  delete "/cart_items" => "cart_items#destroy_all", as: "destroy_all"
  resources :orders, only: [:new, :create, :index, :show] do
    collection do
      get "/confirm" => "orders#confirm", as: "confirm"
      get "/complete" => "orders#complete", as: "complete"
    end
  end
  resource :customers, only: [:show, :update]
  get "/customers/password" => "customers#edit", as: "password_edit"
  get "/customers/quit" => "customers#quit", as: "quit"
  put "/customers/hide" => "customers#hide", as: "hide"
  resources :addresses, only:[:index, :create, :destroy, :edit, :update]
  get 'products/genres/:id', to: 'products#index', as: :products_genre

  # admins routes
  namespace :admins do
  	root to: "home#top", as: "top"
  	resources :products, only: [:index, :new, :create, :show, :edit, :update]
  	resources :genres, only: [:index, :create, :edit, :update]
  	resources :customers, only: [:index, :show, :edit, :update]
  	resources :orders, only: [:index, :show, :update]
  	resources :order_items, only: [:update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
