require 'rails_helper'

RSpec.describe Location, type: :model do
    include_context 'common'

    let(:subject) { create(:location) }

    describe 'attributes' do
        it 'reads and writes :little_brother_chip_id' do
            subject.little_brother_chip_id = uuid
            expect(subject.little_brother_chip_id).to eq(uuid)
        end

        it 'reads and writes :lot_id' do
            subject.lot_id = uuid
            expect(subject.lot_id).to eq(uuid)
        end

        it 'reads and writes :coordinates' do
            subject.coordinates = {}
            expect(subject.coordinates).to eq({})
        end
    end

    describe 'associations' do
        it 'belongs to a little_brother_chip' do
            expect(subject.little_brother_chip).to be_a(LittleBrotherChip)
        end

        it 'belongs to a lot' do
            expect(subject.lot).to be_a(Lot)
        end
    end

    describe 'instance methods' do
        describe '#parse_coordinates' do
            it 'parses coordinates to floats' do
                subject.valid?

                subject.coordinates.map{|k,v|
                    expect(v).to be_a(Float)}
            end
        end
    end
end
