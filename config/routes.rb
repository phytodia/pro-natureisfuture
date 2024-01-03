Rails.application.routes.draw do
  devise_for :commercials

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#home"
  resources :espace_pro, path: "/espace-pro"
  resources :profiles

  resources :products, path: "cosmetiques" do
    member do
      get "delete_photo"
    end
  end


  scope '/admin' do
    resources :team_members
    resources :prospects
  end

  resources :admin

  resources :crm do
    member do
      get :prospects, to: 'crm#crm_prospects'
      get :edit_prospect, :path => "edit"
      patch :update_prospect
      get :show_prospect, :path => "show"
    end
  end

  resources :instituts

end
