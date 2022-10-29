
class User < ApplicationRecord 
    has_many :user_searches
    has_many :searches, through: :user_searches
    has_secure_password

    validates :name,  presence: true, uniqueness: true 
    validates :email,
        format: { 
          with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
        }
    
end
