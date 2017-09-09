class CreateLots < ActiveRecord::Migration[5.1]
    def change
        create_table :lots, id: :uuid do |t|
            t.references :building, type: :uuid, index: true
            t.string :lot_type # can be toilet, room, etc
            t.string :name
            t.integer :floor_level # ground as 0
            t.jsonb :dimensions
            t.timestamps
        end
    end
end
