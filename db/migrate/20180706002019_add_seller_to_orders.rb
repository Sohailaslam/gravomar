class AddSellerToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :seller, :string
  end
end
