require 'rails_helper'

RSpec.describe Beacon, type: :model do
    include_context 'common'

    let(:subject) { create(:beacon) }

    describe 'attributes' do
        it 'reads and writes :lot_id' do
            subject.lot_id = uuid
            expect(subject.lot_id).to eq(uuid)
        end

        it 'reads and writes :manufacturer_uuid' do
            subject.manufacturer_uuid = uuid
            expect(subject.manufacturer_uuid).to eq(uuid)
        end

        it 'reads and writes :coordinates' do
            subject.coordinates = {}
            expect(subject.coordinates).to eq({})
        end

        it 'reads and writes :last_activity' do
            now = Time.now
            subject.last_activity = now
            expect(subject.last_activity).to eq(now)
        end
    end

    describe 'associations' do
        it 'belongs to a lot' do
            expect(subject.lot).to be_a(Lot)
        end

        it 'has a building' do
            expect(subject.building).to eq(subject.lot.building)
        end
    end

    describe 'instance methods' do
        describe '#parse_coordinates' do
            subject { create :beacon, coordinates: {x: "1", y: "-1"} }
            it 'converts coordinates to integers' do

                subject.send :parse_coordinates
                subject.save

                expect(subject.coordinates.to_json)
                    .to be_json_eql({x: 1, y: -1}.to_json)
            end
        end
    end
end
