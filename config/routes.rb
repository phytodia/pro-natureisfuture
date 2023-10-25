Rails.application.routes.draw do

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#home"
  get 'espace_pro/index'
  scope '/admin' do
    resources :profiles
    resources :team_members
  end
  resources :instituts

end
