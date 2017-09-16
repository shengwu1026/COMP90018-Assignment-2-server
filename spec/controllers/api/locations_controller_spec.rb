require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::LocationsController, type: :controller do
    include_context 'common'

    let!(:model) { create :location }
    let(:show_attr) { %w(little_brother_chip_id lot_id coordinates) }
    let(:invalid_model_attributes) { {little_brother_chip_id: nil} }

    it_behaves_like 'a resource controller'

    describe 'PATCH #triangulate' do
        let!(:location) { create :location }
        let(:beacon_1) { create :beacon, coordinates: {x: -1, y: 1}, manufacturer_uuid: SecureRandom.uuid }
        let(:beacon_2) { create :beacon, coordinates: {x: -1, y: -1}, manufacturer_uuid: SecureRandom.uuid }
        let(:beacon_3) { create :beacon, coordinates: {x: 1, y: -1}, manufacturer_uuid: SecureRandom.uuid }
        let(:beacons_array) { [beacon_1, beacon_2, beacon_3].each.with_index(1).map{|b,i|
            {uuid: b.manufacturer_uuid, rssi: i * 10} } }

        it 'updates a little brother chips location' do
            little_brother_chip = location.little_brother_chip

            patch :triangulate, params: {
                id: location.id,
                beacons: beacons_array }

            expect(response).to have_http_status(204)
        end

        describe 'parameters' do
            it 'requires parameters for :beacons' do
                patch :triangulate, params: {id: location.id}

                expect(response.body).to be_json_eql({errors: 'Parameters must have `beacons` key'}.to_json)
            end

            describe ':beacons' do
                it 'has key :rssi' do
                    invalid_beacons = beacons_array.map{|b| b.except :rssi}
                    patch :triangulate, params: {id: location.id, beacons: invalid_beacons}

                    expect(response.body).to be_json_eql({errors: 'Beacon parameters within `beacons` must have `rssi` key'}.to_json)
                end

                it 'has key :uuid' do
                    invalid_beacons = beacons_array.map{|b| b.except :uuid}
                    patch :triangulate, params: {id: location.id, beacons: invalid_beacons}

                    expect(response.body).to be_json_eql({errors: 'Beacon parameters within `beacons` must have `uuid` key'}.to_json)
                end
            end
        end
    end
end
