require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"
require_relative 'scraper_all_recipes_service'

# set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

get '/destroy' do
  cookbook.remove_recipe(params["index"].to_i)
  redirect '/'
end

post '/recipes' do
  name = params["name"]
  description = params["description"]
  rating = params["rating"]
  prep_time = params["prep_time"]
  recipe = Recipe.new(name, description, rating, prep_time)
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/mark-as-done' do
  cookbook.find(params["index"].to_i).mark_as_done
  cookbook.update
  redirect '/'
end

get '/mark-as-undone' do
  cookbook.find(params["index"].to_i).mark_as_undone
  cookbook.update
  redirect '/'
end

get '/import' do
  erb :import
end

post '/list-recipes' do
  ingredient = params["ingredient"]
  @recipes_from_web = ScraperAllrecipesService.new(ingredient).call
  erb :listrecipes
end
