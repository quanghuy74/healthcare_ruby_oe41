class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.references :major, null: false, foreign_key: true
      t.string :name
      t.string :image
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end
