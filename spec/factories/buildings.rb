FactoryGirl.define do
    factory :building do
        name 'University of Melbourne Engineering Building'

        address ({
            unit_number: '1A',
            street_number: '239',
            street_name: 'Parville Road',
            suburb: 'Parville',
            city: 'Melbourne',
            state: 'Victoria',
            post_code: '3052'
            })

        floor_levels ([
            {
                text: 'Ground Floor',
                int: 0,
                length: 100,
                width: 100,
                height: 3,
                units: 'Metres',
            },
            {
                text: 'First Floor',
                int: 1,
                length: 100,
                width: 100,
                height: 3,
                units: 'Metres',
            }
            ])
    end
end
