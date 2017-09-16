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
        major 54321
        minor 12345
    end
end
