require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::BuildingsController, type: :controller do
    let!(:model) { create :building }
    let(:show_attr) { %w(address) }
    let(:invalid_model_attributes) { {address:nil} }

    it_behaves_like 'a resource controller'
end
