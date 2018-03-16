class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :cuisine
  belongs_to :recipe_type
  validates :title, :recipe_type, :difficulty, :cook_time, :ingredients,
            :method, presence: { message: "Você deve informar todos os dados da receita" }
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/default.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

end
