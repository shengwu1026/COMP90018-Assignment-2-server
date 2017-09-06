class Building < ApplicationRecord
    has_many :lots
    has_many :beacons, through: :lots
    has_many :little_brother_chips, through: :lots
    has_many :users, through: :little_brother_chips

    validates_presence_of :address
end
