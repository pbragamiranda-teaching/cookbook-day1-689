# Ask a user for a keyword to search
# Make an HTTP request to the recipe’s website with our keyword
# Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
# Display them in an indexed list
# Ask the user which recipe they want to import (ask for an index)
# Add it to the Cookbook

require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

url = "https://www.allrecipes.com/search/results/?search=banana"
doc = Nokogiri::HTML(URI.open(url).read, nil, 'utf-8')

# p doc.search('.card__recipe').first.search('.card__title').text.strip
# p doc.search('.card__recipe').first.search('.card__summary').text.strip


five_recipes = []

doc.search('.card__recipe').first(5).each do |card_recipe|
  name = card_recipe.search('.card__title').text.strip
  description = card_recipe.search('.card__summary').text.strip
  rating = card_recipe.search('.review-star-text').text.strip.split[1].to_f

  p rating.split[1].to_f
  # five_recipes << Recipe.new(name, description)
end

# five_recipes.each do |recipe|
#   puts "#{recipe.name} - #{recipe.description}"
# end
