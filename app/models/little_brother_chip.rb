class LittleBrotherChip < ApplicationRecord
    belongs_to :user
    has_one :location
    delegate :lot, to: :location
    delegate :building, to: :lot

    def short_location
        (Api::LocationsController.new.send(:displayable_keys).to_a + ['updated_at'])
            .map{|k|
                next if k.eql?('little_brother_chip_id')
                [k, location.send(k.to_sym)]
                }.compact.to_h
    end
end
