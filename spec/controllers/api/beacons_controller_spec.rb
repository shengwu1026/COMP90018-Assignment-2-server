require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::BeaconsController, type: :controller do
    let!(:model) { create :beacon }
    let(:show_attr) { %w(lot_id manufacturer_uuid beacon_type coordinates last_activity) }
    let(:invalid_model_attributes) { {lot_id: nil} }

    it_behaves_like 'a resource controller'
end
