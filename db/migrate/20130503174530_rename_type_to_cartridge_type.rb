class RenameTypeToCartridgeType < ActiveRecord::Migration
  def up
    rename_column :cartridges, :type, :cartridge_type
  end

  def down
    rename_column :cartridges, :cartridge_type, :type
  end
end
