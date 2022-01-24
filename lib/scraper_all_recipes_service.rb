class ScraperAllrecipesService
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@ingredient}"
    html_doc = Nokogiri::HTML(URI.open(url).read, nil, "utf-8")

    recipes = []
    html_doc.search("div.card__detailsContainer").each do |element|
      name = element.search("h3.card__title").text.strip
      description = element.search("div.card__summary").text.strip
      rating_str = element.search("span.review-star-text").text.strip
      rating = rating_str.gsub("Rating:", "").gsub("stars", "").strip

      # Find prept_time
      url_recipe = element.search(".card__titleLink")[0].attribute("href").value
      html_doc_recipe = Nokogiri::HTML(URI.open(url_recipe).read, nil, "utf-8")
      prep_time = html_doc_recipe.search(".recipe-meta-item > div")[1].text.gsub("mins", "").strip

      recipes << Recipe.new(name, description, rating, prep_time)
      break if recipes.size == 5
    end
    recipes
  end
end
