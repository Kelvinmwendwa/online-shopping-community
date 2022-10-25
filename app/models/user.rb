class User < ApplicationRecord
    has_secure_password
 
    has_many :user_searches
    
    validates_uniqueness_of :username, {
        :case_sensitive => true
       }
    validates :username, {
        presence: true
    }
   
end
