class MenuController < ApplicationController
  before_action :authenticate_user!

  def index
    @menu = Menu.all
  end

  def import
    return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
    return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    import = current_user.data_imports.create()
    import.import_file.attach(params[:file])
    redirect_to request.referer, notice: 'Import started...'
  end
end
