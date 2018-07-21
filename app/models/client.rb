class Client < ApplicationRecord
    
    has_many :orders
    enum status: [:non_registered,:registered]
    
    def self.to_csv
        attributes = %w{name phone_number phone_number2 dob email vat}
        attributes_to_send = ["Nome", "Telefone", "2º Telefone", "Data de nascimento", "Email", "NIF"]
    
        CSV.generate(headers: true) do |csv|
          csv << attributes_to_send
    
          all.each do |user|
            csv << attributes.map{ |attr| user.send(attr) }
          end
        end
    end
    
end
