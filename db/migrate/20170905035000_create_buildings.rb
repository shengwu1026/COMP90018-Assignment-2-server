class CreateBuildings < ActiveRecord::Migration[5.1]
    def change
        create_table :buildings, id: :uuid do |t|
            t.jsonb :address
            t.timestamps
        end
    end
end
