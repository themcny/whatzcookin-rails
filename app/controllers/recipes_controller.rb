class RecipesController < ApplicationController
  include TasteProfilesHelper

  def show
    @recipe = Recipe.find_or_create_by(api_id: params[:id])
    @recipe_info = Recipe.get_recipe(params[:id])
    @comments = @recipe.comments.order(:created_at)
    @comment = Comment.new
    if user_signed_in?
      @user_rating = Rating.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    end

    if request.xhr?
      render :show,layout:false
    else
      render :show
    end
  end


  def retrieve_recipes
    recipes = Recipe.get_recipes_by_ingredient(params[:ingredient], 15)
    unless recipes.parsed_response.empty?
      id = recipes.sample['id']
      redirect_to recipe_path(id)
    else
      flash[:error] = "We can't seem to find that ingredient"
      redirect_to root_path
    end
  end

  def random_recipe
    recipe = Recipe.get_random
    id = recipe['id']
    redirect_to recipe_path(id)
  end
end
