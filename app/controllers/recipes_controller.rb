class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update]
  def index
    @recipes = Recipe.all
  end

  def show; end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    return redirect_to @recipe if @recipe.save

    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    render :new
  end

  def edit
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def update
    return redirect_to @recipe if @recipe.update(recipe_params)

    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    render :edit
  end

  def search
    @recipes = Recipe.where("title LIKE ?", "%#{params[:q]}%")
  end

  def my_recipes
    @recipes = current_user.recipes
  end

  def message
    recipe_id = params[:recipe_id].to_i
    name_from = params[:from]
    email_to = params[:to]
    msg = params[:message]
    recipe = Recipe.find(recipe_id)
    RecipesMailer.send_recipe(recipe_id, name_from, email_to, msg).deliver_now
    flash[:notice] = 'Mensagem enviada com sucesso'
    redirect_to recipe
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :photo)
  end
end
