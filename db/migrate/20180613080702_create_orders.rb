class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.text :notes
      t.integer :cost
      t.integer :client_id
      t.date :delivery_date
      t.float :length
      t.float :height
      t.string :frame
      t.string :passe_partout
      t.string :accessory
      t.float :others, default: 0
      t.integer :client_id
      t.integer :status, default: 1
      t.integer :advance, default: 0
      t.integer :discount, default: 0

      t.timestamps
    end
  end
end
