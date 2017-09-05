require 'rails_helper'

RSpec.describe LittleBrotherChip, type: :model do
    include_context 'common'

    let(:subject) { create(:little_brother_chip) }

    describe 'attributes' do
        it 'reads and writes :user_id' do
            subject.user_id = uuid
            expect(subject.user_id).to eq(uuid)
        end
    end

    describe 'associations' do
        before do
            create(:location, little_brother_chip: subject)
        end

        it 'belongs to a user' do
            expect(subject.user).to be_a(User)
        end

        it 'has a location' do
            expect(subject.location).to be_a(Location)
        end

        it 'has a lot' do
            expect(subject.lot).to eq(subject.location.lot)
        end

        it 'has a building' do
            expect(subject.building).to eq(subject.location.lot.building)
        end
    end
end
