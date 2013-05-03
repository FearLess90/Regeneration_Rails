class Cartridge < ActiveRecord::Base
  attr_accessible :description, :name, :cartridge_type, :make_id
  has_many :tasks
  belongs_to :make
end
