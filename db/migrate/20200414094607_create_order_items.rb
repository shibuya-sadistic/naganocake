class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id,          null: false
      t.integer :product_id,        null: false
      t.integer :produce_status,    null: false
      t.integer :piece,             null: false
      t.integer :price,             null: false
      t.integer :product_id,        null: false

      t.references :order, foreign_key: true
      t.references :product, foreign_key: true



      t.timestamps
    end
  end
end
