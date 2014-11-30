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
  get 'm_settings', to: 'pages#mobile_settings'
  get 'settings', to: 'ajax#settings'

  get 'set_notification', to: 'ajax#set_notification'

  get 'visit_link/:id', to: 'shares#visit_link', as: 'visit_link'
  get 'delete_share/:id', to: 'shares#destroy', as: 'delete_share'

  get 'contacts/gmail/callback', to: 'popups#findfriends'
  get 'contacts/failure', to: 'popups#failure'

  namespace :api do
    resources :tips
    get 'friends', to: 'friends#index', via: [:options]
    put 'shares/:id/serve', to: 'shares#serve_link'
    put 'shares/:id/visit', to: 'shares#visit_link'
  end
end
