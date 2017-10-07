require 'rails_helper'

RSpec.describe Lot, type: :model do
    include_context 'common'

    let(:subject) { create(:lot) }

    describe 'attributes' do
        it 'reads and writes :building_id' do
            subject.building_id = uuid
            expect(subject.building_id).to eq(uuid)
        end

        it 'reads and writes :lot_type' do
            subject.lot_type = 'Playground'
            expect(subject.lot_type).to eq('Playground')
        end

        it 'reads and writes :name' do
            subject.name = 'Common facilities - playground under 10 year olds'
            expect(subject.name).to eq('Common facilities - playground under 10 year olds')
        end

        it 'reads and writes :floor_level' do
            subject.floor_level = -1
            expect(subject.floor_level).to eq(-1)
        end

        it 'reads and writes :dimensions' do
            subject.dimensions = {}
            expect(subject.dimensions).to eq({})
        end
    end

    describe 'associations' do
        let(:locations_count) { 10 }
        let(:little_brother_chips_count) { 10 }
        let(:beacons_count) { 50 }

        before do
            create_list(:location, locations_count, lot: subject)
            create_list(:beacon, beacons_count, lot: subject)
        end

        it 'belongs to a building' do
            expect(subject.building).to be_a(Building)
        end

        it 'has many little_brother_chips' do
            expect(subject.little_brother_chips.size).to eq(little_brother_chips_count)
        end

        it 'has as many users as little_brother_chips' do
            expect(subject.users.size).to eq(little_brother_chips_count)
        end

        it 'has many beacons' do
            expect(subject.beacons.size).to eq(beacons_count)
        end

        it 'has many locations' do
            expect(subject.locations.size).to eq(locations_count)
        end
    end
end
