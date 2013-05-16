class Make < ActiveRecord::Base
  attr_accessible :description, :name, :image_url
  has_many :cartridges, :dependent => :destroy

  validates :name, :presence => {:message => "The name is required." }

end
