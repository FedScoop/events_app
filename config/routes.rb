Rails.application.routes.draw do
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

  # ABOUT -----------------------------------------------------------------
  root 'about#index'
  get 'about/speakers' => 'about#speakers'
  get 'about' => 'about#about'
  get 'calendar' => 'about#calendar'
  get 'about/sponsor' => 'about#sponsor'
  get 'about/request-to-speak' => 'about#request_to_speak'

  # USERS -----------------------------------------------------------------
  resources :users, only: [:new, :create]
  get 'users/validate/:id' => 'users#validate', as: 'validate_user'
  get 'users/profile' => 'users#show', as: 'user_profile'
  get 'dashboard' => 'users#dashboard', as: 'dashboard'
  get 'users/edit' => 'users#edit', as: 'edit_user'
  get 'users/edit/password' => 'users#edit_password', as: 'edit_user_password'
  patch 'users/update' => 'users#update', as: 'user'
  patch 'users/update/password' => 'users#update_password', as: 'update_user_password'

  # SESSIONS --------------------------------------------------------------
  get 'login' => 'sessions#new'
  post 'sessions' => 'sessions#create'
  get 'logout' => 'sessions#logout'

  # SPEAKERS --------------------------------------------------------------
  resources :speakers

  # VENUES ----------------------------------------------------------------
  resources :venues

  # SPONSORS --------------------------------------------------------------
  resources :sponsors

  # AGENCIES --------------------------------------------------------------
  resources :agencies
end
