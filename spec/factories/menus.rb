FactoryBot.define do
  factory :menu, class: 'Menu' do
    dish_name { Faker::Food.dish }
    dish_desc { Faker::Food.description  }
    dish_type { Faker::Number.binary(digits: 1) === 0 ? 'Veg' : 'Non-Veg'  }
    allergens { Faker::Food.allergen }
    category { Faker::Food.ethnic_category }
    price { Faker::Number.within(range: 50..250) }
  end
end
