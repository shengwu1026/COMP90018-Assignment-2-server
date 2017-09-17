require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::BeaconsController, type: :controller do
    let!(:model) { create :beacon }
    let(:show_attr) { %w(id lot_id manufacturer_uuid major minor coordinates last_activity) }
    let(:invalid_model_attributes) { {lot_id: nil} }
    let(:successful_create_params) {{
        beacon: {
            manufacturer_uuid: SecureRandom.uuid,
            major: 2,
            minor: 1,
            lot_id: (create :lot).id,
            coordinates: {
                x: 1,
                y: -1
            }
        }
    }}

    it_behaves_like 'a resource controller'
end
