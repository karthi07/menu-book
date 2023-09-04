class Menu < ApplicationRecord
  validates :dish_name, presence: true, uniqueness: true
  validates :price, numericality: true, presence: true
end
