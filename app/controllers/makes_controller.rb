class MakesController < ApplicationController
  
  def index
    if params[:column].nil?
  	  @makes = Make.order('created_at').page(params[:page]).per(5)
    else
      @makes = Make.order(params[:column]+ " " + params[:direction]).page(params[:page]).per(5)
    end
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

  def sort
    respond_to do |format|
      format.html {redirect_to '/'}
      format.js {
        session[:column] = params[:column]
        session[:direction] = params[:direction]
        @makes = Make.order(params[:column]+ " " + params[:direction]).page(params[:page]).per(5)
      }
    end
  end

end
