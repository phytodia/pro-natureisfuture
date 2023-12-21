class CrmController < ApplicationController
  layout "crm"
  def index
    @prospects = Prospect.all
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
end
