class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :firstName
      t.string :lastName
      t.string :streetNumber
      t.string :streetName
      t.string :city
      t.string :postalCode
      t.boolean :isVendor
      t.string :companyName

      t.timestamps
    end
  end
end
