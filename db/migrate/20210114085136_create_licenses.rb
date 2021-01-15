class CreateLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :licenses do |t|
      t.references :major, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.string :level
      t.string :workspace
      t.date :date_of_issue
      t.string :place_of_issue

      t.timestamps
    end
  end
end
