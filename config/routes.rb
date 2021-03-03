Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Check this
  # http://blog.railsupgrade.com/2014/05/how-to-override-devise-default-routes.html

  devise_for :users, :controllers => { :registrations => 'registrations', :confirmations => 'confirmations' },
             path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup'}

  root 'welcome#index'
end
