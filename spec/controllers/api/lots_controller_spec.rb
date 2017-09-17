require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::LotsController, type: :controller do
    let!(:model) { create :lot }
    let(:show_attr) { %w(id building_id lot_type name floor_level dimensions) }
    let(:invalid_model_attributes) { {building_id: nil, name: nil} }
    let(:successful_create_params) {{
        lot: {
            building_id: (create :building).id,
            name: 'lotty',
            floor_level: 2,
            dimensions: {
                units: 'Metres',
                length: 150,
                width: 225,
                height: 30
            },
            rssi_1m_away_from_beacon: 100.0,
            average_phone_height: 3.5,
            path_loss: 50.0,
        }
    }}

    it_behaves_like 'a resource controller'
end
