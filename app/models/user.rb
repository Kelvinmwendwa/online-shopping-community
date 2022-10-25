
class User < ApplicationRecord 
    validates :name, :username, presence: true, uniqueness: true 


    has_secure_password
    validates :email,
        format: { 
          with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
        }
    


class User < ApplicationRecord
    has_secure_password
 
    has_many :user_searches
    has_many :searches, through: :user_searches
    
    validates_uniqueness_of :username, {
        :case_sensitive => true
       }
    validates :username, {
        presence: true
    }
    
end
