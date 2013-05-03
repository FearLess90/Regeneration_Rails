class CartridgesController < ApplicationController
  def index
    if params[:column].nil?
      @cartridges = Cartridge.order('created_at').page(params[:page]).per(5)
    else
      @cartridges = Cartridge.order(params[:column] + ' ' + params[:direction]).page(params[:page]).per(5)
    end
  end

  def new
    @cartridge = Cartridge.new
  end

  def create
    cartridge = Cartridge.new(params[:cartridge])

    if cartridge.valid?
      cartridge.save
      redirect_to cartridges_path, notice: "Cartridge #{cartridge.name} created."
    end
  end

  def show

  end

  def edit
  end

  def update
    cartridge = Cartridge.find(params[:id])
    cartridge.update_attributes(params[:cartridge])

    if cartridge.valid?
      cartridge.save
      redirect_to cartridges_path, notice: "Cartridge #{cartridge.name} updated."
    end
  end
  def sort
    respond_to do |format|
      format.html {redirect_to '/'}
      format.js {
        session[:column] = params[:column]
        session[:direction] = params[:direction]
        @cartridges = Cartridge.order(params[:column]+ " " + params[:direction]).page(params[:page]).per(5)
      }
    end
  end
end
