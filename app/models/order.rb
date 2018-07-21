class Order < ApplicationRecord
    
   # has_one :user

   enum status: [:stimulation, :ongoing, :complete]
   
   has_many :product_orders, dependent: :destroy
   has_many :products, through: :product_orders
   
   belongs_to :client, optional: true
   # accepts_nested_attributes_for :client, reject_if: :all_blank, allow_destroy: true
   
end
