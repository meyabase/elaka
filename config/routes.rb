Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Check this
  # http://blog.railsupgrade.com/2014/05/how-to-override-devise-default-routes.html

  devise_for :users, :controllers => { :registrations => 'registrations', :confirmations => 'confirmations' },
             path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup'}

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  resources :entries do
    resources :reports
    member do
      put 'upvote'
      put 'unupvote'
      put 'downvote'
      put 'undownvote'
      put 'save_entry'
      put 'unsave_entry'
      put 'verify'
      put 'unverify'
    end
  end

  match 'help', to: 'messages#new', :via => 'get'
  resources :messages, only: [:create]

  root 'entries#index'
  match 'reports', to: 'flags#index', :via => 'get'
  match 'search', to: 'pages#search', :via => 'get'
  match 'trending', to: 'pages#trending', :via => 'get'
  match 'users', to: 'pages#users', :via => 'get'
  match 'about', to: 'pages#about', :via => 'get'
  match 'privacy', to: 'pages#privacy', :via => 'get'
  match 'terms', to: 'pages#terms', :via => 'get'
  match 'guidelines', to: 'pages#guidelines', :via => 'get'

  # Make sure profile routes are always last to allow mis-routing
  # See https://stackoverflow.com/questions/16796244/rails-username-in-url
  get ':username', to: 'profiles#show', as: :profile
  get ':username/votes', to: 'profiles#votes', as: :votes
  get ':username/saved', to: 'profiles#saved', as: :saved
  get ':username/verified', to: 'profiles#verified', as: :verified
end
