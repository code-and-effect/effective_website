Rails.application.routes.draw do
  acts_as_archived

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', confirmations: 'users/confirmations', invitations: 'users/invitations' }

  if Rails.env.production?
    require 'sidekiq/web'

    authenticate :user, lambda { |user| user.is?(:admin) } do
      mount Sidekiq::Web => '/admin/sidekick'
    end
  end

  match '/impersonate', to: 'users/impersonations#destroy', via: [:delete], as: :impersonate
  match '/settings', to: 'users/settings#edit', as: :user_settings, via: [:get]
  match '/settings', to: 'users/settings#update', via: [:patch, :put]

  match 'test/exception', to: 'test#exception', via: :get
  match 'test/email', to: 'test#email', via: :get

  namespace :admin do
    resources :mates, only: [:new, :create, :destroy] do
      post :reinvite, on: :member
      post :promote, on: :member
      post :demote, on: :member
    end

    resources :clients, except: [:show], concerns: :acts_as_archived

    resources :users, except: [:show], concerns: :acts_as_archived do
      post :reinvite, on: :member
      post :impersonate, on: :member
    end

    root to: 'users#index'
  end

  # Front end
  resources :clients

  resources :mates, only: [:new, :create, :destroy] do
    post :reinvite, on: :member
    post :promote, on: :member
    post :demote, on: :member
  end

  # if you want EffectivePages to render the home / root page
  # uncomment the following line and create an Effective::Page with slug == 'home'
  # root :to => 'Effective::Pages#show', :id => 'home'
  root to: 'static_pages#home'
end
