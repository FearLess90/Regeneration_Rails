class TasksController < ApplicationController 
	
	def index
		gon.clients = Client.all.map{ |c| { id: c.id, name: "#{c.lastName}, #{c.firstName}"}}.to_json
		@makes  = Make.all
	end

	def create 
		counter = 0
		params[:tasksjson].each do |t|

			task = Task.new(cartridge_id: t[:cartridgeId], client_id: t[:clientId], estimatedCompletitionDate: t[:completitionDate], checkinDate: t[:checkinDate]  )
			if task.valid?
				task.save
				counter += 1
			end
		end
		respond_to do |format|
	      format.html {redirect_to '/'}
	      format.js {
	      	if counter == params[:tasksjson].length
	      		@result = "everything ok"
	      	else
	      		@result = "only #{counter} tasks created out of #{params[:tasksjson].length}."
	      	end

	      	client_id = params[:tasksjson][0][:clientId]

	      	@tasks = Task.find_all_by_client_id(client_id)

	      }
	  	end
	end
end