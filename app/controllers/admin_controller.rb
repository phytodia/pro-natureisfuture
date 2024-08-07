class AdminController < ApplicationController
  before_action :authenticate_user!, :check_admin

  def index
    @profiles = Profile.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def customers
    @customers = Customer.all
  end
  def customer
    @customer = Customer.find(params[:id])
  end

  def admin_soins
    @soins = Soin.all
  end

  def cours
    @cours = Course.all
  end

  def instituts
    #ids_instituts = current_customer.instituts.ids
    @instituts_views = Ahoy::Event.where(name: "institut_view").group_by {|event| event.properties['page_name']}
    #@institut_views = @instituts_views.group_by {|event| event.properties['page_name']}
    #@visits = []
    #ids_instituts.each do |id|
    #  @visits << @datas_first.where("properties @> ?", { institut_id: id }.to_json)
    #end
  end

  def all_posts
    @posts = BlogPost.all
  end

  def edit_home_content
    @reviews = YAML.load_file("#{Rails.root.to_s}/db/yaml/home_avis.yml")
    @instituts_partenaires = YAML.load_file("#{Rails.root.to_s}/db/yaml/home_partenaires.yml")
  end

  def update_home_content
    if params[:content_type] == "avis_home"
      @reviews = YAML.load_file("#{Rails.root.to_s}/db/yaml/home_avis.yml")
      @reviews[params['key']]['review'] = params["new_review"]
      @reviews[params['key']]['note'] = params["new_note"]
      #@reviews[params['key']] = params["new_note"]
      #@reviews[params["new_auteur"]] = @reviews.delete params['key']

      File.write("#{Rails.root.to_s}/db/yaml/home_avis.yml", @reviews.to_yaml)

      # Mettez à jour le paramètre avec les nouvelles valeurs du formulaire
      #@reviews[0]['review'] = params[:review]

      # Enregistrez les modifications dans le fichier YAML

    elsif params[:content_type] == "partenaires"
      @instituts_partenaires = YAML.load_file("#{Rails.root.to_s}/db/yaml/home_partenaires.yml")
      @instituts_partenaires[params["item_number"]]["id"] = params["institut_selected"].to_i

      File.write("#{Rails.root.to_s}/db/yaml/home_partenaires.yml",  @instituts_partenaires.to_yaml)

    end
    redirect_to edit_home_content_path
  end

  private
  def check_admin
    if current_user.profile.role != "admin"
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cet espace"
    else
    end
  end

end
