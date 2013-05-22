class TasksController < ApplicationController 
	
	def index
		gon.clients = Client.all.map{ |c| { id: c.id, name: "#{c.lastName}, #{c.firstName}"}}.to_json
		@makes  = Make.all
	end

	def create 

		test = ActiveSupport::JSON.decode(params[:tasksjson].to_json)
		test["results"].each do |cartridgeId, clientId|
		  cartr = Cartridge.find(cartridgeId)
		  debugger
		end
		debugger
		render :index
	end
end