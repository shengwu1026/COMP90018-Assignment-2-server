require 'rails_helper'

RSpec.describe Building, type: :model do
    let(:subject) { create(:building) }

    describe 'attributes' do
        it 'reads and writes :name' do
            subject.name = 'newname'
            expect(subject.name).to eq('newname')
        end

        it 'reads and writes :address' do
            subject.address = {}
            expect(subject.address).to eq({})
        end

        it 'reads and writes :floor_levels' do
            subject.floor_levels = [{}]
            expect(subject.floor_levels).to eq([{}])
        end
    end

    describe 'associations' do
        let(:lot_count) { 3 }
        let(:beacons_per_lot) { 5 }
        let(:little_brother_chips_per_lot) { 10 }

        before do
            create_list(:lot, lot_count, building: subject) do |lot|
                create_list(:beacon, beacons_per_lot, lot: lot)
                create_list(:location, little_brother_chips_per_lot, lot: lot)
            end
        end

        it 'has many lots' do
            expect(subject.lots.size).to eq(lot_count)
        end

        it 'has many beacons' do
            expect(subject.beacons.size).to eq(lot_count * beacons_per_lot)
        end

        it 'has many little_brother_chips' do
            expect(subject.little_brother_chips.size).to eq(lot_count * little_brother_chips_per_lot)
        end

        it 'has as many users as little_brother_chips' do
            expect(subject.users.size).to eq(lot_count * little_brother_chips_per_lot)
        end
    end

    describe 'instance methods' do
        describe '#parse_floor_level_dimensions' do
            subject { create :building, floor_levels:
                    [{int: "1", length: "100", width: "100", height: "3", units: "Metres", text: "1st floor"}] }

            it 'converts coordinates to integers' do

                subject.send :parse_floor_level_dimensions
                subject.save

                # test all these json values are of int type
                floor_level = subject.floor_levels.first

                %w(int length width height).each do |k|
                    expect(floor_level[k]).to be_a(Integer)
                end
            end
        end
    end
end
