class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :location, :password_digest
  
end
