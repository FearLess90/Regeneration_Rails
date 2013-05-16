class ClientsController < ApplicationController
	def index
		if params[:column].nil?
	  	  @clients = Client.order('created_at').page(params[:page]).per(5)
	    else
	      @clients = Client.order(params[:column]+ " " + params[:direction]).page(params[:page]).per(5)
	    end
	end
	def new
		@client = Client.new
	end
	def create
		@client = Client.new(params[:client])
		if @client.valid?
			@client.save
			redirect_to clients_path, notice: "Client #{@client.firstName} #{@client.lastName} created."
		else
			render :new
		end
	end

	def show
		@client = Client.find(params[:id])
	end

	def edit
		@client = Client.find(params[:id])
	end

	def update
		@client = Client.find(params[:id])
		@client.update_attributes(params[:client])
		if @client.valid?
			@client.save
			redirect_to clients_path, notice: "Client #{@client.firstName} #{@client.lastName} updated."
		end
	end

	def destroy
		@client = Client.find(params[:id])
		unless @client.nil?
			@client.destroy
			redirect_to clients_path, notice: "Client #{@client.firstName} #{@client.lastName} deleted."
		end
	end

  	def sort
	    respond_to do |format|
	      format.html {redirect_to '/'}
	      format.js {
	        session[:column] = params[:column]
	        session[:direction] = params[:direction]
	        @clients = Client.order(params[:column]+ " " + params[:direction]).page(params[:page]).per(5)
	      }
    end
  end


end