class Lot < ApplicationRecord
    belongs_to :building

    has_many :locations
    has_many :beacons
    has_many :little_brother_chips, through: :locations
    has_many :users, through: :little_brother_chips
end
