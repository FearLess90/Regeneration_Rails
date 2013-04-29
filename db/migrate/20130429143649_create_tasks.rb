class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.date :checkinDate
      t.date :estimatedCompletitionDate
      t.boolean :isComplete
      t.date :completitionDate
      t.decimal :price
      t.references :client
      t.references :cartridge
      t.timestamps
    end
  end
end
