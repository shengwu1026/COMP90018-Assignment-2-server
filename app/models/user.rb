class User < ApplicationRecord
    has_secure_password

    has_one :little_brother_chip
    delegate :location, to: :little_brother_chip
end
