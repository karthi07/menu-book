class ImportMenuJob
  include Sidekiq::Job

  require 'csv'

  Sidekiq.strict_args!(false)

  def perform(data_import_id)
    @data_import = DataImport.find(data_import_id)
    menu_items, failed_items = parse_and_build_menu
    Menu.import(menu_items,synchronize: menu_items, on_duplicate_key_ignore: true, track_validation_failures: true, validate: true, batch_size: 1000)
  end

  def update_menu_item(current_menu, row)
    current_menu['dish_desc'] = row['dish_desc']
    current_menu['dish_type'] = row['dish_type']
    current_menu['allergens'] = row['allergens']
    current_menu['category'] = row['category']
    current_menu['price'] = row['price']
    current_menu.save
  end

  def parse_and_build_menu()
    data_file = @data_import.import_file.download
    
    menu_items = []
    failed_items = []
    import_file = @data_import.import_file.download

    if @data_import.data_type == 'text/csv'
      data = CSV.parse(import_file, headers: true)
    else
      file_path = ActiveStorage::Blob.service.path_for(@data_import.import_file.key).to_s
      sheet = Roo::Spreadsheet.open(file_path,extension: :xlsx) # open spreadsheet
      converted_file=sheet.to_csv
      data = CSV.parse(converted_file, headers: true)
    end
    data.each do |row|
      current_menu = Menu.find_by(dish_name: row['dish_name'])
      update_menu_item(current_menu, row) if current_menu.present? && current_menu.valid?
      current_menu ||= Menu.new(row.to_h.with_indifferent_access.except(:id))
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
