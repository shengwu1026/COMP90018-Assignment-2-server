class CreateLocations < ActiveRecord::Migration[5.1]
    def change
        create_table :locations, id: :uuid do |t|
            t.references :little_brother_chip, type: :uuid, index: true
            t.references :lot, type: :uuid, index: true
            t.jsonb :coordinates
            t.timestamps
        end
    end
end
