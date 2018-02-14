class Recipe < ApplicationRecord
  validates :title, :recipe_type, :cuisine, :ingredients, :method, presence: true
end
