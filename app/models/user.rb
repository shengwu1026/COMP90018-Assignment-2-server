class User < ApplicationRecord
    has_secure_password

    has_one :little_brother_chip
    delegate :location, to: :little_brother_chip

    validates_presence_of :password_digest, :first_name, :last_name, :username    
end
