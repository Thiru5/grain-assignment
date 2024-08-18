class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :type
      t.string :identifier
      t.string :label
      t.string :description
      t.float :price

      t.timestamps
    end
  end
end
