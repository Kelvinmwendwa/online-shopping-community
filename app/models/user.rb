class User < ApplicationRecord 
    validates :name, :username, presence: true, uniqueness: true 


    has_secure_password
    validates :email,
        format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    

end
