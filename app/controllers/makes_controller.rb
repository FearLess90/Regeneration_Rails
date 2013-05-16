require 'JSON'
require 'open-uri'
require 'net/http'

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
  		redirect_to makes_path, notice: "Make #{@make.name} Created"
  	else
  		render :new
  	end

  end

  def show
      @make = Make.find(params[:id])
      get_image @make
      @cartridges = @make.cartridges.page(params[:page]).per(5)
      #@response = JSON(open('http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=' + @make.name + '+logo').read)
      
  end

  def edit
       @make = Make.find(params[:id])
  end

  def update
      @make = Make.find(params[:id])
      @make.update_attributes(params[:make])

    if @make.valid?
      @make.save
      redirect_to makes_path, notice: "Make #{@make.name} successfully Updated."
    end
  end

  def destroy
      @make = Make.find(params[:id])
      unless @make.nil?
        @make.destroy
        redirect_to makes_path, notice: "Make #{@make.name} successfully Destroyed."
      end
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

  def sort_cartridges
    respond_to do |format|
      format.html {redirect_to '/'}
      format.js {
        session[:column] = params[:column]
        session[:direction] = params[:direction]
        @cartridges = Make.find(params[:id]).cartridges.order(params[:column]+ " " + params[:direction]).page(params[:page]).per(5)
      }
    end
  end

  def get_image(make)
    if make.image_url.nil?
      response = JSON(open('http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=' + @make.name + '+logo').read)
      make.image_url = response['responseData']['results'][0]['url']
      make.save
    else
      url = URI.parse(make.image_url)
      request = Net::HTTP.new(url.host, url.port)
      response = request.request_head(url.path)
      unless response.code == "200"
        response = JSON(open('http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=' + @make.name + '+logo').read)
        make.image_url = response['responseData']['results'][0]['url']
        make.save
      end
    end
  end

end
