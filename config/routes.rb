Rails.application.routes.draw do
  devise_for :users

  match '/settings', to: 'user_settings#edit', as: :user_settings, via: [:get]
  match '/settings', to: 'user_settings#update', via: [:patch, :put]

  namespace :admin do
    resources :users, except: [:show] do
      get :unarchive, on: :member
    end

    root to: 'pages#index'
  end

  match 'test/exception', to: 'static_pages#exception', via: :get

  root to: 'static_pages#home'
end
