FactoryGirl.define do
    factory :user do
        first_name 'John'
        last_name 'Doe'
        password 'secr@t'
        username { "#{first_name}.#{last_name}@example.com".downcase }
    end
end
