defprotocol Faros.Categories.CategoryFor do

  def save_relation(thing, category)

  def find_categories_for(thing)
end
