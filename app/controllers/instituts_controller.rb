class InstitutsController < ApplicationController
  def index
    @instituts = Institut.all
  end

  def show
    @institut = Institut.find(params[:id])
  end

  def new
    @institut = Institut.new
  end

  def create
    @institut = Institut.new(institut_params)
    @institut.save
    if @institut.save
      redirect_to admin_index_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def institut_params
    params.require(:institut).permit(:name, :profile_id)
  end
end
