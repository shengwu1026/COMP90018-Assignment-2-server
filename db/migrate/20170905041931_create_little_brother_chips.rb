class CreateLittleBrotherChips < ActiveRecord::Migration[5.1]
    def change
        create_table :little_brother_chips, id: :uuid do |t|
            t.references :user, type: :uuid, index: true
            t.timestamps
        end
    end
end
