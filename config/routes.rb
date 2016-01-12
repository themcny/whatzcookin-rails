Rails.application.routes.draw do

  get 'favorites/index'

  get 'favorites/show'

  get 'favorites/edit'

  get 'favorites/new'

  resources :recipes do
    resources :comments
  end
  resources :recipes do
    resources :ratings
  end

  resources :welcome, only: [:index]
  post '/retrieve_recipes' => 'recipes#retrieve_recipes'
  root 'welcome#index'
  post '/random_recipe' => 'recipes#random_recipe'

  # Nested nutritional profile under Devise scope

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", registrations: 'registrations' }

  devise_scope :user do
    resources :users do
      resources :nutritional_profiles
      resources :favorites , only: [:index, :create, :destroy]
    end
    get '/register' => 'devise/registrations#new'
    post '/register' => 'devise/registrations#create'

    get '/login' => 'devise/sessions#new'
    post '/login' => 'devise/sessions#create'
    delete "/logout" => "devise/sessions#destroy"
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
