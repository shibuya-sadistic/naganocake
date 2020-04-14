class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
    	t.string :name,               null: false
    	t.text :introduction,         null: false
    	t.references :genre,          null: false, foreign_key: true
    	t.integer :price,             null: false
    	t.string :image_id
    	t.boolean :status,            null: false, default: true

      t.timestamps
    end
  end
end
