class AddFieldsToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :frame_cost, :decimal
    add_column :orders, :accessory_cost, :decimal
    add_column :orders, :passe_partout_cost, :decimal
    add_column :orders, :tax_cost, :decimal
    add_column :orders, :discount_amount, :decimal
  end
end
