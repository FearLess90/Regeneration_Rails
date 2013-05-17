class TasksController < ApplicationController 
	
	def index
		@clients = Client.all.map{ |c| { id: c.id, name: "#{c.lastName}, #{c.firstName}"}}.to_json
	end
end