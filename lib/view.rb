class View

  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}: #{recipe.description}"
    end

  end

  def ask_for_stuff(stuff)
    puts "what is the #{stuff}"
    print ">"
    gets.chomp
  end

  def ask_for_index
    puts "what is the index you want to del"
    print ">"
    gets.chomp.to_i -1
  end

end
