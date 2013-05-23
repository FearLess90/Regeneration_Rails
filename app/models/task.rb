class Task < ActiveRecord::Base
  attr_accessible :checkinDate, :completitionDate, :estimatedCompletitionDate, :isComplete, :price, :cartridge_id, :client_id
  belongs_to :client
  belongs_to :cartridge
end
