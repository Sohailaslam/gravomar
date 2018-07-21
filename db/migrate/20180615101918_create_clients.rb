class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone_number
      t.string :phone_number2
      t.date :dob
      t.integer :vat
      t.text :notes
      t.boolean :admin, default: false
      t.integer :order_id
      t.string :email
      t.timestamps
    end
  end
end
