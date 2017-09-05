FactoryGirl.define do
    factory :location do
        little_brother_chip
        lot

        coordinates ({
            x: 20,
            y: 50
            })
    end    
end
