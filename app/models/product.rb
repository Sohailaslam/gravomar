class Product < ApplicationRecord
    
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    
    validates_uniqueness_of :product_code
    
    enum kind: [:frame, :passe_partout, :accessory]
    
    has_many :product_orders, dependent: :destroy
    has_many :orders, through: :product_orders
    
    def self.to_csv
        attributes = %w{product_code kind cost color height width price	notes}
        attributes_to_send = ["Identificador (ref)", "Tipo", "Custo (cm)", "Côr", "Altura (cm)", "Largura (cm)", "Preço (cm)",	"Notas"]
    
        CSV.generate(headers: true) do |csv|
          csv << attributes_to_send
    
          all.each do |user|
            csv << attributes.map{ |attr| user.send(attr) }
          end
        end
    end
    
end
