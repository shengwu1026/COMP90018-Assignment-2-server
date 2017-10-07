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
                length: 150.0,
                width: 225.0,
                height: 30.0
            }
        }
    }}

    it_behaves_like 'a resource controller'
end
