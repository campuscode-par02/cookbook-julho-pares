class CuisinesController < ApplicationController

  before_action :set_cuisine, only: %i[show]

  def show; end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    flash[:success] = "Cozinha cadastrada com sucesso"
    return redirect_to @cuisine if @cuisine.save
    render :new
  end

  private

  def set_cuisine
    @cuisine = Cuisine.find(params[:id])
  end

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

  
  
end