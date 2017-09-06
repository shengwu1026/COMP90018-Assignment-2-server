class Lot < ApplicationRecord
    belongs_to :building

    has_many :locations
    has_many :beacons
    has_many :little_brother_chips, through: :locations
    has_many :users, through: :little_brother_chips

    validates_presence_of :building, :name, :floor_level, :dimensions
end
