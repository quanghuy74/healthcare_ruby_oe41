class AddInformationToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :account_name, :string
    add_column :orders, :phone, :string
    add_column :orders, :address, :string
  end
end
