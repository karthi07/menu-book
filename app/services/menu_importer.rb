class MenuImporter
  require 'csv'

  def call(file)
    menu_items, failed_items = parse_and_build_menu(file)

    ImportMenuJob.perform_async(menu_items)

  end

  def parse_and_build_menu(importFile)
    opened_file = File.open(importFile)
    options = { headers: true, col_sep: ',' }
    menu_items = []
    failed_items = []
    CSV.foreach(opened_file, **options) do |row|
      current_menu = Menu.find_by(dish_name: row['dish_name'])
      current_menu ||= Menu.new(row)
      if current_menu.valid?
        menu_items << current_menu
      else
        row['errors'] = current_menu.errors.full_messages.join(', ')
        failed_items << row
      end 
    end
    [menu_items, failed_items]
  end
end