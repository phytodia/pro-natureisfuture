Rails.application.routes.draw do

  devise_for :customers
  devise_for :commercials
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #get '/contact', to: redirect('/instituts', status: 301) #Test redirection
  # Defines the root path route ("/")
  scope "(:locale)", locale: /fr/ do
    root to: "pages#home"
    get "contact", to: "pages#contact"
    get "envoye", to: "pages#send_contact"
    get "formations", to: "pages#formations"
    get "devenir-partenaire",to: "pages#partenaire"


    resources :espace_pro, path: "/espace-pro" do
      member do
        get "etablissements", to: "espace_pro#etablissements"
        get "cours-formations", to: "espace_pro#cours"
        get "commandes",to: "espace_pro#commandes"
        resources :custom_soins, only: [:index,:new,:create,:edit,:update,:destroy], path:"soins-personnalises"
        resources :cartes, only: [:new,:create,:show,:destroy]
        resources :courses, only: [:index, :show]
      end
      collection do
        get "produits", to: "espace_pro#produits"
        get "faq",to:"espace_pro#faq"
        get "phototheque",to: "espace_pro#phototheque"
        get :institut, to: "espace_pro#institut_show", path: "/etablissements/:id"
        get :edit_institut, to: "espace_pro#edit_institut", path: "/etablissements/:id/edit"
        patch :update_institut, to: "espace_pro#update_institut"
        get "delete_photo", to: "espace_pro#delete_photo"
        get "soins",to:"espace_pro#soins"
      end
    end

    resources :profiles

    resources :products, path: "cosmetiques" do
      member do
        get "delete_photo"
      end
      collection do
        #get "/filtres", to: "products#filtres",as: :cosmetique_filtres
      end
    end
    #get "/corps", to: "products#category", as: :cosmetique_corps
    resources :soins do
      collection do
        get :visage
        get :corps
        get :massages
      end
    end
    post "soins/filter", to: "soins#filter"


    scope '/admin' do
      resources :team_members
      resources :prospects
      resources :courses, only: [:new,:create,:edit,:update,:destroy]
      resources :chapters, only: [:new,:create,:edit,:update,:destroy]
      get :clients, to: "admin#customers", path: "/clients"
      get :client, to: "admin#customer", path: "/clients/:id"
    end

    resources :admin

    resources :crm do
      collection do
        get :prospects, to: 'crm#crm_prospects', path: ":id/prospects"
        get :show_prospect, :path => "show", path: "prospect/:id"
        get :new_prospect,to: 'crm#new_prospect', :path => "/new"
        get :edit_prospect, :path => "prospect/:id/edit"
        get :clients, to: "crm#crm_customers", path: ":id/clients"
        get :customer, to: "crm#show_customer", path: "/client/:id"
        get :new_customer, to: "crm#new_customer"
        get :edit_customer, to: "crm#edit_customer", path: "/client/:id/edit"

        get :new_institut, to: "crm#new_institut"
        get :edit_institut, to: "crm#edit_institut", path: "instituts/:id/edit"
        post :create_institut, to: "crm#create_institut"

        get "delete_photo", to: "crm#delete_photo"

        get :filter_up, to: "crm#filter_up"

        post :create_customer, to: "crm#create_customer"
        post :create_prospect, to: "crm#create_prospect"

        resources :orders

      end
      member do
        patch :update_prospect
        patch :update_customer, to: "crm#update_customer"
        patch :update_institut, to: "crm#update_institut"

        #get :prospects, to: 'crm#crm_prospects'
        #get :edit_prospect, :path => "edit"
        #patch :update_prospect
        #get :show_prospect, :path => "show"
        #get :clients, to: "crm#crm_customers"
        #get :new_customer, to: "crm#new_customer"
        #post :create_customer, to: "crm#create_customer"
        #get :new_institut, to: "crm#new_institut"
        ##get "/client", to: "crm#show_customer"
      end
    end




    resources :instituts, path:"instituts-bio" do
      collection do
        get :send_contact, path:"send"
      end
    end

    get "/:category", to: "products#categories", as: :cosmetique_category
    post "/:category/filter", to: "products#filter", as: :filter_category

  end
end
