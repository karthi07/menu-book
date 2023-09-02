class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :dish_name
      t.string :dish_desc
      t.string :dish_type
      t.string :allergens
      t.string :category
      t.float :price

      t.timestamps
    end
  end
end
