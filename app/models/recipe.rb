class Recipe < ApplicationRecord
  belongs_to :cuisine
  validates :title, :recipe_type, :ingredients, :method, presence: true
end
