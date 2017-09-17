require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::BuildingsController, type: :controller do
    let!(:model) { create :building }
    let(:show_attr) { %w(id name address floor_levels) }
    let(:invalid_model_attributes) { {address: {}, floor_levels: [{fake_key: 1}]} }
    let(:successful_create_params) {{
        building: {
            address: {
                unit_number: '1A',
                street_number: '239',
                street_name: 'Parville Road',
                suburb: 'Parville',
                city: 'Melbourne',
                state: 'Victoria',
                post_code: '3052'
            },
            floor_levels: [
                {
                    text: 'Ground Floor',
                    int: 0,
                    length: 100,
                    width: 100,
                    height: 3,
                    units: 'Metres',
                }
            ]
        }
    }}

    it_behaves_like 'a resource controller'
end
