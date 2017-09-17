class Building < ApplicationRecord
    has_many :lots
    has_many :beacons, through: :lots
    has_many :little_brother_chips, through: :lots
    has_many :users, through: :little_brother_chips

    # validates_presence_of :address, blank: false

    # before_initialize :parse_floor_level_dimensions
    before_save :parse_floor_level_dimensions
    validate :validate_floor_levels, :validate_address

    private
        def parse_floor_level_dimensions
            # raise self.inspect
            if floor_levels.present?
                self.floor_levels = floor_levels.map{|f|
                    # convert int length width height to integers
                    f.map{|k,v|
                        k.in?(%w(int length width height)) ?
                            [k, v.to_i]
                            : [k, v]
                    }.to_h
                }
            end
        end

        def validate_floor_levels
            if floor_levels.present?
                floor_levels.each do |f|
                    %w(text int length width height units).each do |key|
                        errors.add("Floor Level #{key}", "can't be blank") if f[key].blank?
                    end
                end
            end
        end

        def validate_address
            errors.add(:address, "can't be blank") unless address.present?
        end
end
