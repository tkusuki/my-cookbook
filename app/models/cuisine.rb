class Cuisine < ApplicationRecord
  has_many :recipes, dependent: :destroy
  validates :name, presence: {
    message: 'Você deve informar o nome da cozinha'
  }
  validates :name, uniqueness: {
    message: 'Já existe uma cozinha cadastrada com esse nome'
  }
end
