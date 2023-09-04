class AddIndexToMenu < ActiveRecord::Migration[7.0]
  def change
    add_index :menus, :dish_name, unique: true
    add_index :menus, :category
  end
end
