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

       before_create :set_expire_at

       def set_expire_at
        self.expire_at=Time.now + 1.week
       end
end
