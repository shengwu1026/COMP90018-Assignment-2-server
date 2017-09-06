FactoryGirl.define do
    factory :beacon do
        lot

        manufacturer_uuid SecureRandom.uuid
        beacon_type 'Edge'
        coordinates ({
            x: 0,
            y: 0
            })
        last_activity Time.now
    end
end
