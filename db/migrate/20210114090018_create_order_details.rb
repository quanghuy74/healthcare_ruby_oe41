class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.integer :status, default: 0
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :into_money

      t.timestamps
    end
  end
end
