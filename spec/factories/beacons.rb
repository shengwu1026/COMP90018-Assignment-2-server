FactoryGirl.define do
    factory :beacon do
        lot

        manufacturer_uuid SecureRandom.uuid
        # beacon_type 'Edge'
        coordinates ({
            x: 0,
            y: 0
            })
        last_activity Time.now
        major (10000..99999).to_a.sample
        minor (10000..99999).to_a.sample
    end
end
