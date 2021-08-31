class InventoryItems < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_items do |t|
      t.references  :survivor, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
