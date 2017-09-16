class CreateLots < ActiveRecord::Migration[5.1]
    def change
        create_table :lots, id: :uuid do |t|
            t.references :building, type: :uuid, index: true
            t.string :lot_type # can be toilet, room, etc
            t.string :name
            t.integer :floor_level # ground as 0
            t.jsonb :dimensions
            t.float :rssi_1m_away_from_beacon
            t.float :average_phone_height
            t.float :path_loss
            t.timestamps
        end
    end
end
