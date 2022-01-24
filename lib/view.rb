class View
  def ask_user_for(field)
    puts "#{field.capitalize} of your recipe ?"
    print "> "
    gets.chomp
  end

  def ask_user_for_ingredient
    puts "What ingredient would you like a recipe for?"
    print "> "
    ingredient = gets.chomp
    puts "Look for \"#{ingredient}\" recipes on the Internet..."
    puts ""
    ingredient
  end

  def ask_user_for_index
    puts "Index of the recipe ?"
    print "> "
    gets.chomp.to_i - 1
  end

  def ask_user_for_recipe_to_import
    puts "Which recipe would you like to import? (enter index)"
    print "> "
    gets.chomp.to_i - 1
  end

  def show_recipe_to_import(recipe)
    puts "Importing \"#{recipe.name}\"..."
  end

  def show_first_five_recipes(recipes)
    recipes.first(5).each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}"
    end
    puts ""
  end

  def display(recipes)
    recipes.each_with_index do |recipe, index|
      recipe_done = recipe.done? ? "X" : " "
      puts "#{index + 1}. [#{recipe_done}] #{recipe.name} : #{recipe.description} - #{recipe.rating} stars - #{recipe.prep_time} minutes"
    end
  end
end
