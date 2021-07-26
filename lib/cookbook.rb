require 'csv'

class Cookbook

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    #array of instances of Recipe class
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(new_recipe)
    @recipes << new_recipe
    save_csv
  end


  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def find(index)
    @recipes[index]
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end


  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time]
      end
    end
  end

end
