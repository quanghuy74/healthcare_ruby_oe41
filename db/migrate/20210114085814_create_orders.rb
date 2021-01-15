class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :staff_id
      t.text :depcription
      t.integer :status
      t.decimal :total_price

      t.timestamps
    end
  end
end
