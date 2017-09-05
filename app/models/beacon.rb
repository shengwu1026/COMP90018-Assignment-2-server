class Beacon < ApplicationRecord
    belongs_to :lot
    delegate :building, to: :lot
end
