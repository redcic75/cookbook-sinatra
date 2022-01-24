require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"
require_relative "scraper_all_recipes_service"

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
  params["name"]
  redirect '/'
end

post '/recipes' do
  name = params["name"]
  description = params["description"]
  recipe = Recipe.new(name, description, "5", "30")
  cookbook.add_recipe(recipe)
  redirect '/'
end
