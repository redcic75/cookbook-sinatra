require_relative 'view'
require_relative 'recipe'
require_relative 'scraper_all_recipes_service'
require "open-uri"
require "nokogiri"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display
  end

  def create
    name = @view.ask_user_for("name")
    description = @view.ask_user_for("description")
    rating = @view.ask_user_for("rating")
    prep_time = @view.ask_user_for("preparation time")
    @cookbook.add_recipe(Recipe.new(name, description, rating, prep_time))
  end

  def destroy
    display
    index = @view.ask_user_for_index
    @cookbook.remove_recipe(index)
  end

  def import_recipes
    # With a local file
    # file = "strawberry.html"
    # html_doc = Nokogiri::HTML(File.open(file), nil, "utf-8")

    # With an http request
    ingredient = @view.ask_user_for_ingredient
    recipes = ScraperAllrecipesService.new(ingredient).call

    @view.show_first_five_recipes(recipes)
    index = @view.ask_user_for_recipe_to_import
    @view.show_recipe_to_import(recipes[index])
    @cookbook.add_recipe(recipes[index])
  end

  def mark_recipe_as_done
    display
    index = @view.ask_user_for_index
    @cookbook.find(index).mark_as_done
    @cookbook.update
  end

  private

  def display
    recipes = @cookbook.all
    @view.display(recipes)
    puts ""
  end
end
