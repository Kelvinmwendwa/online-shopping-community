class Product < ApplicationRecord
    belongs_to :search
    validates :name, {
     presence: true
    }
    validates :shop, {
        presence: true
       }
    validates :price, {
        presence: true
       }
end
