class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
    	t.references :customer, foreign_key: true, null: false
    	t.string :user_id, null: false #payjpの顧客id
    	t.string :card_id, null: false
        t.timestamps
    end
  end
end
