class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :full_name
      t.date :date_of_birth
      t.integer :gender, default: 0
      t.string :card_id
      t.string :address
      t.integer :role, null: false, default: 0
      t.integer :status, default: 1
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
  end
end
