class MenuController < ApplicationController
  def index
    @menu = Menu.all
  end
end
