require 'matrix'

class Location < ApplicationRecord
    belongs_to :little_brother_chip
    belongs_to :lot

    validates_presence_of :little_brother_chip, :lot, :coordinates

    before_save :parse_coordinates

    # set new coordinates
    def update_coordinates(array_of_3_beacon_hashes)
        self.coordinates = triangulate array_of_3_beacon_hashes
    end

    # note, moved rssi_1m_away_from_beacon, path_loss, average_phone_height out of args
    # def distance_from_phone(rssi)
    #     raw_distance = 10 ** ((lot.rssi_1m_away_from_beacon - rssi) / (10 * lot.path_loss))
    #     Math.sqrt( (raw_distance ** 2) - (lot.average_phone_height ** 2) )
    # end

    private
        def parse_coordinates
            self.coordinates = self.coordinates.map{|k,v| [k,v.to_f]}.to_h
        end

        # hash must include :rssi and :distance_from_phone key
        def weighted_location(array_of_3_beacon_hashes)
            weight = array_of_3_beacon_hashes.map{|b| 1.0 / b[:distance_from_phone] }.sum

            # expect weighted (x,y) matrix
            coordinates_array = unweighted_location(array_of_3_beacon_hashes)
                .map{|coordinate| weight * coordinate}.to_a.flatten

            {x: coordinates_array.first, y: coordinates_array.second}
        end
        alias_method :triangulate, :weighted_location

        def unweighted_location(array_of_3_beacon_hashes)
            # beacon hashes required to have keys :coordinates and :distance_from_phone
            beacon_1 = array_of_3_beacon_hashes.first
            beacon_2 = array_of_3_beacon_hashes.second
            beacon_3 = array_of_3_beacon_hashes.third

            # 2 by 2 matrix
            matrix_A = Matrix[
                # row 1
                [   ((beacon_1[:coordinates][:x] - beacon_3[:coordinates][:x]) * 2), # col 1
                    ((beacon_1[:coordinates][:y] - beacon_3[:coordinates][:y]) * 2) ], # col 2

                # row 2
                [   ((beacon_2[:coordinates][:x] - beacon_3[:coordinates][:x]) * 2), # col 1
                    ((beacon_2[:coordinates][:y] - beacon_3[:coordinates][:y]) * 2) ] # col 2
            ]

            # 2 by 1
            matrix_B = Matrix[
                # row 1
                [   (beacon_1[:coordinates][:x] ** 2) - (beacon_3[:coordinates][:x] ** 2) +
                    (beacon_1[:coordinates][:y] ** 2) - (beacon_3[:coordinates][:y] ** 2) +
                    (beacon_3[:distance_from_phone] ** 2) - (beacon_1[:distance_from_phone] ** 2) ],

                #row 2
                [   (beacon_2[:coordinates][:x] ** 2) - (beacon_3[:coordinates][:x] ** 2) +
                    (beacon_2[:coordinates][:y] ** 2) - (beacon_3[:coordinates][:y] ** 2) +
                    (beacon_3[:distance_from_phone] ** 2) - (beacon_2[:distance_from_phone] ** 2) ]
            ]

            # returns matrix 1 by 2, corresponds to [x,y] coordinates
            (matrix_A.transpose * matrix_A)
                .inverse * matrix_A.transpose * matrix_B
        end
end
