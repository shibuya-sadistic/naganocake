class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, 			null: false, foreign_key: true
      t.integer :postage,				null: false, default: 800
      t.string :destination, 			null: false
      t.string :postcode, 				null: false
      t.string :address, 				null: false
      t.integer :payment, 				null: false
      t.integer :status, 				null: false, default: 0

      t.timestamps
    end
  end
end
