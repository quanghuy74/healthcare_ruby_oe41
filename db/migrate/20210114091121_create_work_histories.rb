class CreateWorkHistories < ActiveRecord::Migration[6.1]	
  def change
    create_table :work_histories do |t|
      t.references :order_detail, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
