class LittleBrotherChip < ApplicationRecord
    belongs_to :user
    has_one :location
    delegate :lot, to: :location
    delegate :building, to: :lot
end
