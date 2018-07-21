class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :cost
      t.string :color
      t.integer :height
      t.integer :width
      t.integer :price
      t.text :notes
      t.string :frame
      t.string :passe_partout
      t.string :accessory
      t.string :seller
      t.integer :stock
      t.integer :kind
      t.string :product_code
      
      t.timestamps
    end
    add_attachment :products, :image
    add_index :products, :product_code, unique: true
  end
end
