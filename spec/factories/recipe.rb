FactoryBot.define do
  factory :recipe do
    title 'Cuscuz Marroquino'
    difficulty 0
    cook_time 40
    ingredients 'Cuscuz marroquino, caldo de legumes, salsinha e uvas-passas'
    add_attribute(:method) do
      'Dissolva o caldo de legumes em água fervente e coloque no cuscuz'
    end
    cuisine
    recipe_type
    user
  end
end
