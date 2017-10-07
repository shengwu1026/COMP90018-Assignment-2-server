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

    describe 'GET #fetch_little_brother_chips' do
        subject { create :lot }
        let!(:little_brother_chip) { create :little_brother_chip }
        let!(:location) { create :location, lot: subject, little_brother_chip: little_brother_chip }

        it 'returns coordinates of little brother chips in this Lot' do
            get :fetch_little_brother_chips, params: {lot_id: subject.id}

            expect(response.body).to be_json_eql(
                {little_brother_chips:
                    [{
                        id: little_brother_chip.id,
                        coordinates: little_brother_chip.location.coordinates
                    }]
                }.to_json)
        end
    end
end
