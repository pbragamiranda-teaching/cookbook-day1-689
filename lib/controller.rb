require_relative 'view'
require_relative 'recipe'

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
    # 2. create new instance of Recipe
    new_recipe = Recipe.new(name, description)
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


end
