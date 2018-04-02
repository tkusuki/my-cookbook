class RecipeType < ApplicationRecord
  has_many :recipes, dependent: :destroy
  validates :name, presence: {
    message: 'Você deve informar o nome do tipo de receita'
  }
  validates :name, uniqueness: {
    message: 'Já existe um tipo de receita cadastrada com esse nome'
  }
end
