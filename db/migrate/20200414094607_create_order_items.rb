class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order,          null: false, foreign_key: true
      t.references :product,        null: false, foreign_key: true
      t.integer :produce_status,    null: false, default: 0
      t.integer :piece,             null: false
      t.integer :price,             null: false

      t.timestamps
    end
  end
end
