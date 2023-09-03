class CreateDataImports < ActiveRecord::Migration[7.0]
  def change
    create_table :data_imports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :data_type
      t.integer :status
      t.integer :total_records

      t.timestamps
    end
  end
end
