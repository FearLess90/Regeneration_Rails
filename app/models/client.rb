class Client < ActiveRecord::Base
  attr_accessible :city, :companyName, :firstName, :isVendor, :lastName, :postalCode, :streetName, :streetNumber
  has_many :tasks
end
