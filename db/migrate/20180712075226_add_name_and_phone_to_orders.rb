class AddNameAndPhoneToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :client_name, :string
    add_column :orders, :client_phone, :string
  end
end
