class Recipe
  attr_reader :name, :description, :prep_time, :rating

  def initialize(name, description, rating, prep_time, done = false)
    @name = name
    @description = description
    @rating = rating
    @prep_time = prep_time
    @done = done
  end

  def done?
    @done
  end

  def mark_as_done
    @done = true
  end

  def mark_as_undone
    @done = false
  end
end
