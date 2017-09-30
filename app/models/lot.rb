class Lot < ApplicationRecord
    belongs_to :building

    has_many :locations
    has_many :beacons
    has_many :little_brother_chips, through: :locations
    has_many :users, through: :little_brother_chips

    validates_presence_of :building, :name, :floor_level,
        :dimensions, :rssi_1m_away_from_beacon, :average_phone_height,
        :path_loss

    before_save :parse_dimensions

    private
        def parse_dimensions
            if dimensions.present?
                self.dimensions = dimensions.map{|k,v|
                    k.in?(%w(length width height)) ?
                        [k, v.to_f]
                        : [k, v] }.to_h
            end
        end
end
