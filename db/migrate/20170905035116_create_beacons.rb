class CreateBeacons < ActiveRecord::Migration[5.1]
    def change
        create_table :beacons, id: :uuid do |t|
            t.references :lot, type: :uuid, index: true
            t.string :manufacturer_uuid # pre-programmed uuid
            t.string :beacon_type # can be normal or edge beacons
            t.jsonb :coordinates
            t.datetime :last_activity # detect potentially faulty beacons
            t.timestamps
        end
    end
end
