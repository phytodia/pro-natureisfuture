Rails.application.routes.draw do

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#home"
  resources :espace_pro, path: "/espace-pro"
  resources :profiles
  resources :admin
  resources :products, path: "cosmetiques" do
    member do
      get "delete_photo"
    end
  end


  scope '/admin' do
    resources :team_members
  end

  resources :crm

  resources :instituts

end
