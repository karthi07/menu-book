class MenuController < ApplicationController
  before_action :authenticate_user!

  def index
    # @menu = Menu.all

    @category = Menu.select("category").group("category")

  end

  def import
    return redirect_to request.referer, alert: 'No file added' if params[:file].nil?
    return redirect_to request.referer, notice: "Only CSV and excel files allowed. got #{params[:file].content_type}"  unless ['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'text/csv'].include? params[:file].content_type 

    import = current_user.data_imports.create(data_type: params[:file].content_type)
    import.import_file.attach(params[:file])
    redirect_to request.referer, notice: 'Import started...'
  end
end
