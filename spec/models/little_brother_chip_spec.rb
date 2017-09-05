require 'rails_helper'

RSpec.describe LittleBrotherChip, type: :model do
    include_context 'common'

    let(:subject) { create(:little_brother_chip) }

    it 'reads and writes :user_id' do
        subject.user_id = uuid
        expect(subject.user_id).to eq(uuid)
    end

    describe 'associations' do
        it 'belongs to a user' do
            expect(subject.user).to be_a(User)
        end        
    end
end
