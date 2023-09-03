class DataImport < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, processing: 1, completed: 2, failed: 3 }

  has_one_attached :import_file

  after_create_commit :process_data_import

  private

  def process_data_import
    ImportMenuJob.perform_async(self.id)
  end
end
