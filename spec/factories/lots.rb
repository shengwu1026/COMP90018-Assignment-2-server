FactoryGirl.define do
    factory :lot do
        building

        lot_type 'Toilet'
        name 'Ground Floor Section A Male Toilet'
        floor_level 'Ground Floor'
        dimensions ({
            units: 'Metres',
            length: 50,
            width: 25,
            height: 3
            })
    end
end
