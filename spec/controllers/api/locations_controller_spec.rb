require 'rails_helper'
require 'support/resource_controller'

RSpec.describe Api::LocationsController, type: :controller do
    include_context 'common'

    let!(:model) { create :location }
    let(:show_attr) { %w(id little_brother_chip_id lot_id coordinates) }
    let(:invalid_model_attributes) { {little_brother_chip_id: nil} }
    let(:successful_create_params) {{
        location: {
            little_brother_chip_id: (create :little_brother_chip).id,
            lot_id: (create :lot).id,
            coordinates: {
                x: 20.0,
                y: 10.0
            }
        }
    }}

    it_behaves_like 'a resource controller'

    describe 'GET #fetch' do
        context 'if location exists for the little brother chip' do
            let!(:location) { create :location, lot: lot }
            let(:lot) { create :lot, building: building }
            let(:building) { create :building }
            let(:little_brother_chip) { location.little_brother_chip }

            it 'fetches the location of a little brother chip' do
                get :fetch, params: { little_brother_chip_id: little_brother_chip.id }

                expect(response.body).to be_json_eql(
                    {
                        id: location.id,
                        lot: lot.attributes.select{|k,v| k.in? %w(id name floor_levels dimensions)},
                        building: building.attributes.select{|k,v| k.in? %w(id name address)},
                        coordinates: location.coordinates
                    }.to_json)
            end
        end

        context 'if location does not exist for the little brother chip' do
            let(:little_brother_chip) { create :little_brother_chip }

            it 'returns an empty location with `id` being null' do
                get :fetch, params: { little_brother_chip_id: little_brother_chip.id }

                expect(response.body).to be_json_eql(
                    {id: nil, lot: nil, building: nil, coordinates: nil}.to_json)
            end
        end
    end

    # this will fail now, remove on next test run
    # fetching based on little brother chip id rather than location id
    describe 'PATCH #triangulate' do
        let!(:location) { create :location }
        let(:little_brother_chip) { location.little_brother_chip }
        let(:beacon_1) { create :beacon, coordinates: {x: -1, y: 1}, manufacturer_uuid: SecureRandom.uuid }
        let(:beacon_2) { create :beacon, coordinates: {x: -1, y: -1}, manufacturer_uuid: SecureRandom.uuid }
        let(:beacon_3) { create :beacon, coordinates: {x: 1, y: -1}, manufacturer_uuid: SecureRandom.uuid }
        let(:beacons_array) { [beacon_1, beacon_2, beacon_3].each.with_index(1).map{|b,i|
            {uuid: b.manufacturer_uuid, distance_from_phone: i * 10, major: b.major, minor: b.minor} } }

        context 'when no location can be found for a little brother chip' do
            let(:little_brother_chip) { create :little_brother_chip }

            it 'creates a location and sets its coordinates' do
                expect(little_brother_chip.location).to be_nil

                patch :triangulate, params: {
                    little_brother_chip_id: little_brother_chip.id,
                    beacons: beacons_array,
                    coordinates: {x: 10.0, y: 20.0}}

                expect(response).to have_http_status(204)

                little_brother_chip.reload

                expect(little_brother_chip.location).not_to be_nil
            end
        end

        it 'updates a little brother chips location' do
            patch :triangulate, params: {
                little_brother_chip_id: little_brother_chip.id,
                beacons: beacons_array,
                coordinates: {x: 1.0, y: 2.0} }

            expect(response).to have_http_status(204)
        end

        describe 'parameters' do
            it 'requires parameters for :beacons' do
                patch :triangulate, params: {little_brother_chip_id: little_brother_chip.id}

                expect(response.body).to be_json_eql({errors: 'Parameters must have `beacons` key'}.to_json)
            end

            describe ':beacons' do
                it 'has key :distance_from_phone' do
                    invalid_beacons = beacons_array.map{|b| b.except :distance_from_phone}
                    patch :triangulate, params: {little_brother_chip_id: little_brother_chip.id, beacons: invalid_beacons}

                    expect(response.body).to be_json_eql({errors: 'Beacon parameters within `beacons` must have `distance_from_phone` key'}.to_json)
                end

                it 'has key :uuid' do
                    invalid_beacons = beacons_array.map{|b| b.except :uuid}
                    patch :triangulate, params: {little_brother_chip_id: little_brother_chip.id, beacons: invalid_beacons}

                    expect(response.body).to be_json_eql({errors: 'Beacon parameters within `beacons` must have `uuid` key'}.to_json)
                end

                it 'has key :major' do
                    invalid_beacons = beacons_array.map{|b| b.except :major}
                    patch :triangulate, params: {little_brother_chip_id: little_brother_chip.id, beacons: invalid_beacons}

                    expect(response.body).to be_json_eql({errors: 'Beacon parameters within `beacons` must have `major` key'}.to_json)
                end

                it 'has key :minor' do
                    invalid_beacons = beacons_array.map{|b| b.except :minor}
                    patch :triangulate, params: {little_brother_chip_id: little_brother_chip.id, beacons: invalid_beacons}

                    expect(response.body).to be_json_eql({errors: 'Beacon parameters within `beacons` must have `minor` key'}.to_json)
                end
            end
        end
    end
end
