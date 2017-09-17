class Beacon < ApplicationRecord
    belongs_to :lot
    delegate :building, to: :lot

    validates_presence_of :manufacturer_uuid, :major, :minor

    before_save :parse_coordinates

    private
        def parse_coordinates
            self.coordinates = self.coordinates.map{|k,v| [k,v.to_i]}.to_h
        end
end
