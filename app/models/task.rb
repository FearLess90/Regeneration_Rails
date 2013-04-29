class Task < ActiveRecord::Base
  attr_accessible :checkinDate, :completitionDate, :estimatedCompletitionDate, :isComplete, :price
  belongs_to :client
  belongs_to :cartridge
end
