require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(csv_file_path) do |row|
      done = row[4] == "true"
      recipe = Recipe.new(row[0], row[1], row[2], row[3], done)
      @recipes << recipe
    end
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end

  def update
    write_csv
  end

  def add_recipe(recipe)
    @recipes << recipe
    write_csv
    # CSV.open(@csv_file_path, "ab") do |csv|
    #   csv << [recipe.name, recipe.description, recipe.rating, false]
    # end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    write_csv
  end

  private

  def write_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
