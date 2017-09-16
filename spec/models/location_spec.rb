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
        let(:valid_params) { [
            {coordinates: {x:0,y:0}, distance_from_phone: 1.0},
            {coordinates: {x:1,y:1}, distance_from_phone: 2.0},
            {coordinates: {x:0,y:1}, distance_from_phone: 3.0} ] }

        # only valid with exactly 3 hashes
        let(:invalid_params) { valid_params.take 2 }

        describe '#update_coordinates' do
            it 'sets the current coordinates' do
                subject.update_coordinates valid_params

                expect(subject.coordinates.symbolize_keys)
                    .to eq( {x: 5.5, y: -6.416666666666666} )
            end
        end

        describe '#distance_from_phone' do
            let(:rssi) { 50 }

            it 'returns the distance of a phone from a beacon' do
                expect(subject.distance_from_phone(rssi).round(3))
                    .to eq(0.955)
            end
        end

        describe '#unweighted_location' do
            describe 'parameters' do
                it 'accepts an array of 3 beacon hashes with keys :coordinates and :distance_from_phone' do
                    expect{ subject.send :unweighted_location, invalid_params }.to raise_error(Exception)
                    expect{ subject.send :unweighted_location, valid_params }.not_to raise_error(Exception)
                end
            end

            it 'returns raw coordinates' do
                expect(subject.send :unweighted_location, valid_params)
                    .to eq(Matrix[ [3.0], [-3.5] ])
            end
        end

        describe 'weighted_location' do
            describe 'parameters' do
                it 'accepts any arbitrary number of :distance_from_phone values' do
                    expect{ subject.send :weighted_location, invalid_params }.to raise_error(Exception)
                    expect{ subject.send :weighted_location, valid_params }.not_to raise_error(Exception)
                end
            end

            it 'returns weighted coordinates' do
                expect(subject.send :weighted_location, valid_params)
                    .to eq( {x: 5.5, y: -6.416666666666666} )
            end
        end
    end
end
