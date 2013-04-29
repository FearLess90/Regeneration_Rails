class Make < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :cartridges

  validates :name, :presence => {:message => "The name is required." }

end
