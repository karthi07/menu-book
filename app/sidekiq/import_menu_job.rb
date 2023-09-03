class ImportMenuJob
  include Sidekiq::Job

  Sidekiq.strict_args!(false)

  def perform()
    # menu = parse_and_build_menu()
    # Menu.import(menu_items, batch_size: 1000)
    
  end

  def parse_and_build_menu()
    
    opened_file = File.open(importFile)
    options = { headers: true, col_sep: ',' }
    menu_items = []
    failed_items = []
    CSV.foreach(opened_file, **options) do |row|
      current_menu = Menu.find_by(dish_name: row.dish_name)
      current_menu ||= Menu.new(row)
      if current_menu.valid?
        menu_items << current_menu
      else
        row['errors'] = current_menu.errors.full_messages.join(', ')
        failed_items << row
      end 
    end

    Menu.import(menu_items, batch_size: 1000)

  end
end
