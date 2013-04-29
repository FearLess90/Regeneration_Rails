class CreateCartridges < ActiveRecord::Migration
  def change
    create_table :cartridges do |t|
      t.string :name
      t.string :description
      t.string :type
      t.references :make
      t.timestamps
    end
  end
end
