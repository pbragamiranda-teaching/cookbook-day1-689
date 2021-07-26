class Recipe

  attr_reader :name, :description, :rating, :prep_time

  def initialize(name, description, rating, prep_time)
    @name = name
    @description = description
    @rating = rating
    @prep_time = prep_time
    @completed = false
  end

  def mark_as_complete!
    @completed = true
  end

  def completed?
    @completed
  end

end

