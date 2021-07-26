require_relative 'view'
require_relative 'recipe'
require 'nokogiri'
require 'open-uri'

class Controller

  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end


  def list
    # 1. get all recipes from cookbook
    recipes = @cookbook.all
    # 2. tells the view to print recipes
    @view.display(recipes)
  end

  def create
    # 1. get input from the user
    name = @view.ask_for_stuff('name')
    description = @view.ask_for_stuff('description')
    rating = @view.ask_for_stuff('rating')
    prep_time = @view.ask_for_stuff('pre time')
    # 2. create new instance of Recipe
    new_recipe = Recipe.new(name, description, rating, prep_time)
    # 3. add to repo (cookbook)
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # 1. display recipes and ask user which to delete
    list
    index = @view.ask_for_index
    # 2. fetch the right one from cookbook
    # 3. delete it
    @cookbook.delete(index)
  end


  def import
    # Ask a user for a keyword to search
    keyword = @view.ask_for_stuff("keyword you want to search?")
    # Make an HTTP request to the recipe’s website with our keyword
    # Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
    recipes = scraper(keyword)
    # Display them in an indexed list
    @view.display(recipes)
    # Ask the user which recipe they want to import (ask for an index)
    new_recipe = recipes[@view.ask_for_index]
    # Add it to the Cookbook
    @cookbook.add_recipe(new_recipe)
  end

  def mark_recipe_as_done
    # list all recipes
    list
    # ask user which one
    index = @view.ask_for_index
    # fetch the right recipe from the cookbook
    recipe = @cookbook.find(index)
    # mark as completed
    recipe.mark_as_complete!
    # list again to make user happy
    list
  end

  private

  def scraper(keyword)
    url = "https://www.allrecipes.com/search/results/?search=#{keyword}"
    doc = Nokogiri::HTML(URI.open(url).read, nil, 'utf-8')

    five_recipes = []

    doc.search('.card__recipe').first(5).each do |card_recipe|
      name = card_recipe.search('.card__title').text.strip
      description = card_recipe.search('.card__summary').text.strip
      rating = card_recipe.search('.review-star-text').text.strip.split[1].to_f
      five_recipes << Recipe.new(name, description, rating, nil)
    end
    return five_recipes
  end


end
