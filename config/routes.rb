Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', invitations: 'users/invitations' }

  devise_scope :user do
    post 'invitation/:id/reinvite', to: 'users/invitations#reinvite', as: :reinvite_user_invitation
  end

  match '/settings', to: 'user_settings#edit', as: :user_settings, via: [:get]
  match '/settings', to: 'user_settings#update', via: [:patch, :put]

  namespace :admin do
    resources :users, except: [:show] do
      get :unarchive, on: :member
    end

    resources :invitations, only: [:new, :create]

    root to: 'pages#index'
  end

  match 'test/exception', to: 'static_pages#exception', via: :get

  root to: 'static_pages#home'
end
