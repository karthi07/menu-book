class MenuImporter
  require 'csv'

  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: ',' }
    CSV.foreach(opened_file, **options) do |row|
      # map the CSV columns to your database columns
      menu_obj = {}
      menu_obj[:dish_name] = row['dish_name']
      menu_obj[:dish_desc] = row['dish_description']
      menu_obj[:dish_type] = row['dish_type']
      menu_obj[:allergens] = row['allergens']
      menu_obj[:category] = row['category']
      menu_obj[:price] = row['price']

      Menu.find_or_create_by!(menu_obj)
      # for performance, you could create a separate job to import each user
      # CsvImportJob.perform_later(menu_obj)
    end
  end
end