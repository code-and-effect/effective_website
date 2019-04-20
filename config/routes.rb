Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', confirmations: 'users/confirmations', invitations: 'users/invitations' }

  devise_scope :user do
    post 'invitation/:id/reinvite', to: 'users/invitations#reinvite', as: :reinvite_user_invitation

    match '/impersonate/:id', to: 'users/impersonations#create', via: [:patch, :put, :post], as: :impersonate_user
    match '/impersonate', to: 'users/impersonations#destroy', via: [:delete], as: :impersonate
  end

  if Rails.env.production?
    require 'sidekiq/web'

    authenticate :user, lambda { |user| user.is?(:superadmin) } do
      mount Sidekiq::Web => '/admin/sidekick'
    end
  end

  match '/settings', to: 'users/settings#edit', as: :user_settings, via: [:get]
  match '/settings', to: 'users/settings#update', via: [:patch, :put]

  acts_as_archived

  namespace :admin do
    resources :mates, only: [:new, :create, :destroy] do
      post :reinvite, on: :member
      post :promote, on: :member
      post :demote, on: :member
    end

    resources :clients, except: [:show], concerns: :acts_as_archived
    resources :users, except: [:show], concerns: :acts_as_archived

    root to: 'users#index'
  end

  # Front end
  resources :clients

  resources :mates, only: [:new, :create, :destroy] do
    post :reinvite, on: :member
    post :promote, on: :member
    post :demote, on: :member
  end

  match 'test/exception', to: 'test#exception', via: :get
  match 'test/email', to: 'test#email', via: :get

  # if you want EffectivePages to render the home / root page
  # uncomment the following line and create an Effective::Page with slug == 'home'
  # root :to => 'Effective::Pages#show', :id => 'home'
  root to: 'static_pages#home'
end
