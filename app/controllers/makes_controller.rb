class MakesController < ApplicationController
  
  def index
  	@makes = Make.order("created_at").page(params[:page]).per(5)
  end

  def new 
  	@make = Make.new
  end

  def create
  	@make = Make.new(params[:make])
  	if @make.valid?
  		@make.save
  		redirect_to makes_path, :notice => "Make Created " + make.name
  	else 
  		render :new
  	end

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

end
