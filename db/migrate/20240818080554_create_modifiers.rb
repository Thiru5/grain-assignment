class CreateModifiers < ActiveRecord::Migration[7.2]
  def change
    create_table :modifiers do |t|
      t.references :item, null: false, foreign_key: true
      t.references :modifier_group, null: false, foreign_key: true
      t.integer :display_order, default: 0
      t.integer :default_quantity, default: 0
      t.float :price_override

      t.timestamps
    end
  end
end
