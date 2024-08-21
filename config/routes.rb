Rails.application.routes.draw do

  devise_for :customers
  devise_for :commercials
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #get '/contact', to: redirect('/instituts', status: 301) #Test redirection
  get "/fr/instituts-bio", to: redirect('/fr/instituts-beaute', status: 301)
  get "/fr/instituts-de-beaute-bio", to: redirect('/fr/instituts-beaute', status: 301)
  get "/fr/instituts-beaute-bio", to: redirect('/fr/instituts-beaute', status: 301)

  get "/fr/instituts-beaute-bio/nature-creative", to: redirect('/fr/instituts-beaute/nature-creative', status: 301)
  get "/fr/instituts-beaute-bio/rita-esthetique", to: redirect('/fr/instituts-beaute/rita-esthetique', status: 301)
  get "/fr/instituts-beaute-bio/liesse-beaute", to: redirect('/fr/instituts-beaute/liesse-beaute', status: 301)
  get "/fr/instituts-beaute-bio/le-clos-des-sources", to: redirect('/fr/instituts-beaute/le-clos-des-sources', status: 301)
  get "/fr/instituts-beaute-bio/ali-s-heaven-institut", to: redirect('/fr/instituts-beaute/ali-s-heaven-institut', status: 301)
  get "/fr/instituts-beaute-bio/zen-ment-belle", to: redirect('/fr/instituts-beaute/zen-ment-belle', status: 301)
  get "/fr/instituts-beaute-bio/liesse-beaute", to: redirect('/fr/instituts-beaute/liesse-beaute', status: 301)


  #get '/fr/contact', to: redirect('/fr/instituts-beaute', status: 302)
  # Defines the root path route ("/")
  scope "(:locale)", locale: /fr/ do
    root to: "pages#home"
    get "contact", to: "pages#contact"
    get "envoye", to: "pages#send_contact"
    get "formations", to: "pages#formations"
    get "donnees-personnelles",to: "pages#donnees"
    get "politique-confidentialite",to: "pages#confidentialite"
    get "gestion-cookies",to: "pages#cookies"
    get "mentions-legales",to:"pages#mentions"
    get "devenir-partenaire",to:"pages#devenir_partenaire"
    get "/instituts-beaute/region/:region", to: "pages#region", as: :region
    get :send_partenaire, to:"pages#send_partenaire",path:"send_partenaire"



    resources :espace_pro, path: "/espace-pro" do
      member do
        get "etablissements", to: "espace_pro#etablissements"
        get "cours-formations", to: "espace_pro#cours"
        get "commandes",to: "espace_pro#commandes"
        get "rendez-vous", to:"espace_pro#rdv"
        get "statistiques",to:"espace_pro#statistiques"
        get "edit_profile", to: "espace_pro#edit_profile"
        patch "update_profile", to: "espace_pro#update_profile"
        resources :custom_soins, only: [:index,:new,:create,:edit,:update,:destroy], path:"soins-personnalises"
        resources :cartes, only: [:new,:create,:show,:destroy]
        resources :stock_instituts, only: [:index,:edit,:update], path: "stock"
        resources :courses, only: [:index, :show]
        resources :carte_cadeaus, only: [:index,:show,:new,:create,:destroy], path: "cheques-cadeau"
        get :send_cheque, to: "carte_cadeaus#send_cheque"
        get :update_status, to: "espace_pro#update_status"
        #get :note_to_message, to: "espace_pro#note_to_message"
        post :addnote, to: "espace_pro#addnote"
      end
      collection do
        get "produits", to: "espace_pro#produits"
        get "faq",to:"espace_pro#faq"
        get "phototheque",to: "espace_pro#phototheque"
        get :institut, to: "espace_pro#institut_show", path: "/etablissements/:id"
        get :edit_institut, to: "espace_pro#edit_institut", path: "/etablissements/:id/edit"
        patch :update_institut, to: "espace_pro#update_institut"
        get "delete_photo", to: "espace_pro#delete_photo"
        get "delete_promo", to: "espace_pro#delete_promo"
        get "soins",to:"espace_pro#soins"
      end
    end

    resources :profiles

    resources :blog_posts, only: [:index,:show], path:"blog"

    resources :products, path: "cosmetiques" do
      member do
        get "delete_photo"
      end
      collection do
        #get "/filtres", to: "products#filtres",as: :cosmetique_filtres
        get "click-and-collect",to: "products#click_and_collect", as: :click_collect
      end
    end
    #get "/corps", to: "products#category", as: :cosmetique_corps
    resources :soins do
      collection do
        get :visage
        get :corps
        get :massages
        get "cat_bis", to: "soins#cat_bis"
        get :reserver, to: "soins#reservation", path: "/reserver/:soin"
      end
    end
    post "soins/filter", to: "soins#filter"


    scope '/admin' do
      resources :team_members
      resources :prospects
      resources :courses, only: [:new,:create,:edit,:update,:destroy]
      resources :blog_posts, only: [:new,:create,:edit,:update,:destroy]
      get :all_posts, to: "admin#all_posts"
      resources :chapters, only: [:new,:create,:edit,:update,:destroy]
      get "/soins", to: "admin#admin_soins", as: :admin_soins
      get :clients, to: "admin#customers", path: "/clients"
      get :client, to: "admin#customer", path: "/clients/:id"
      get "/tous-les-cours", to: "admin#cours"
      get :instituts, to: "admin#instituts", as: :admin_instituts
      get :preview, to: "courses#preview", path: "/courses/:id/preview"
      get :edit_home_content, to: "admin#edit_home_content"
      post :update_home_content, to: "admin#update_home_content"

      resources :slider_homes, only: [:index] do
        resources :slide_items, only: [:new,:create,:edit,:update,:destroy]
      end

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
        get :statistiques, to: "crm#statistiques", path: ":id/statistiques"

        get :filter_up, to: "crm#filter_up"
        get :filter_down, to: "crm#filter_down"

        post :create_customer, to: "crm#create_customer"
        post :create_prospect, to: "crm#create_prospect"

        get :prospection, to: "crm#prospection"
        get :request_prospection, to: "crm#request_prospection"

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




    resources :instituts, path:"instituts-beaute" do
      collection do
        get :send_contact, path:"send"
        get "/:region/:lieu", to: "instituts#lieu", as: :ville
        get "/villes",to: "instituts#villes", as: :all_villes
      end
    end

    get "/:category", to: "products#categories", as: :cosmetique_category
    post "/:category/filter", to: "products#filter", as: :filter_category

    #get "instituts-beaute/:region/:lieu", to: "instituts#lieu", as: :ville

  end
end
