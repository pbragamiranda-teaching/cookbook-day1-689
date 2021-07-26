class View

  def display(recipes)
    recipes.each_with_index do |recipe, index|
      # condiition ? code_truthy : code_falsey
      status = recipe.completed? ? "X" : " "
      puts "#{index + 1} [#{status}] -  #{recipe.name}: #{recipe.description}"
    end

  end

  def ask_for_stuff(stuff)
    puts "what is the #{stuff}"
    print ">"
    gets.chomp
  end

  def ask_for_index
    puts "what is the index?"
    print ">"
    gets.chomp.to_i - 1
  end

end
