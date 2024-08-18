class CreateSectionItems < ActiveRecord::Migration[7.2]
  def change
    create_table :section_items do |t|
      t.references :section, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :display_order, default: 0

      t.timestamps
    end
  end
end
