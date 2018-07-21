class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :phone
      t.string :material
      t.date :delivery_date
      t.integer :quantity
      t.float :cost
      t.text :description

      t.timestamps
    end
  end
end
