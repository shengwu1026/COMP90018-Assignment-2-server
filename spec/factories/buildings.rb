FactoryGirl.define do
    factory :building do
        address ({
            unit_number: '1A',
            street_number: '239',
            street_name: 'Parville Road',
            suburb: 'Parville',
            city: 'Melbourne',
            state: 'Victoria',
            post_code: '3052'
            })
    end
end
