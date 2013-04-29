class Cartridge < ActiveRecord::Base
  attr_accessible :description, :name, :type
  has_many :tasks
  belongs_to :make
end
