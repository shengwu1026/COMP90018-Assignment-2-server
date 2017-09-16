class Beacon < ApplicationRecord
    belongs_to :lot
    delegate :building, to: :lot

    validates_presence_of :manufacturer_uuid, :major, :minor
end
