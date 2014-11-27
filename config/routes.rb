Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, :skip => [:sessions], :controllers => {registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks"}

  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get 'api_login', to: 'popups#api_login'
  end

  unauthenticated :user do
    root "pages#front"
  end

  authenticated :user do
    root "users#show", as: :authenticated_root
  end

  resources :tips
  resources :friendships

  get 'users/:id', to: 'users#show', as: 'profile'
  get 'inbox', to: 'pages#inbox'
  get 'settings', to: 'ajax#settings'
  get 'visit_link/:id', to: 'shares#visit_link'
  get 'delete_share/:id', to: 'shares#destroy'

  get 'contacts/gmail/callback', to: 'omni#findfriends'
  get 'contacts/failure', to: 'omni#failure'

  namespace :api do
    resources :tips
    get 'friends', to: 'friends#index'
    put 'shares/:id/serve', to: 'shares#serve_link'
    put 'shares/:id/visit', to: 'shares#visit_link'
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
