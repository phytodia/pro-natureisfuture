Rails.application.routes.draw do
  get 'profiles/index'
  get 'profiles/show'
  get 'profiles/new'
  get 'profiles/create'
  get 'profiles/edit'
  get 'profiles/update'
  get 'profiles/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#home"
  get 'espace_pro/index'
end
