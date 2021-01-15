class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.text :content
      t.integer :rate
      t.references :reviewable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
