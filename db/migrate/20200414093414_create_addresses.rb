class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :customer, 		null: false, foreign_key: true
      t.string :destination, 		null: false
      t.string :postcode, 			null: false
      t.string :address, 			null: false

      t.timestamps
    end
  end
end
