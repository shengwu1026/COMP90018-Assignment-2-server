class Location < ApplicationRecord
    belongs_to :little_brother_chip
    belongs_to :lot

    validates_presence_of :little_brother_chip, :lot, :coordinates
end
