class Location < ApplicationRecord
    belongs_to :little_brother_chip
    belongs_to :lot

    validates_presence_of :little_brother_chip, :lot, :coordinates

    before_save :parse_coordinates

    private
        def parse_coordinates
            self.coordinates = self.coordinates.map{|k,v| [k,v.to_f]}.to_h
        end
end
