class RemovePasswordDegitsFromAccount < ActiveRecord::Migration[6.1]
  def change
    remove_column :accounts, :password_digest, :string
  end
end