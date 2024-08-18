class RenameTypeToItemType < ActiveRecord::Migration[7.2]
  def change
    rename_column :items, :type, :item_type
  end
end
