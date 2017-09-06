require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::LotsController, type: :controller do
    let!(:model) { create :lot }
    let(:show_attr) { %w(building_id type name floor_level dimensions) }
    let(:invalid_model_attributes) { {building_id: nil, name: nil} }

    it_behaves_like 'a resource controller'
end
