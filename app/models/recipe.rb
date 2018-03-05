class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :cuisine
  belongs_to :recipe_type
  validates :title, :recipe_type, :difficulty, :cook_time, :ingredients,
            :method, presence: { message: "Você deve informar todos os dados da receita" }
end
