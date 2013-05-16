class AddImageUrlColumnToMake < ActiveRecord::Migration
  def change
    add_column :makes, :image_url, :string
  end
end
