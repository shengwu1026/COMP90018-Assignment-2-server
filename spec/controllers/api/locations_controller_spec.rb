require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::LocationsController, type: :controller do
    let!(:model) { create :location }
    let(:show_attr) { %w(little_brother_chip_id lot_id coordinates) }
    let(:invalid_model_attributes) { {little_brother_chip_id: nil} }

    it_behaves_like 'a resource controller'
end
