FactoryGirl.define do
    factory :lot do
        building

        lot_type 'Toilet'
        name 'Ground Floor Section A Male Toilet'
        floor_level 0
        dimensions ({
            units: 'Metres',
            length: 50,
            width: 25,
            height: 3
            })

        rssi_1m_away_from_beacon 100.0
        average_phone_height 1.5
        path_loss 20.0
    end
end
