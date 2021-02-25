class DropTableWorkHistories < ActiveRecord::Migration[6.1]
  def change
    drop_table :work_histories
  end
end
