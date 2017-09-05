require 'rails_helper'

RSpec.describe User, type: :model do
    let(:subject) { create(:user) }

    describe 'attributes' do
        it 'reads and writes :username' do
            subject.username = 'uname'
            expect(subject.username).to eq('uname')
        end

        it 'reads and writes :password_digest' do
            subject.password_digest = nil
            subject.password = 'pw'
            expect(subject.password_digest).to_not be_nil
            expect(subject.authenticate 'pw').to be_truthy
        end

        it 'reads and writes :first_name' do
            subject.first_name = 'fn'
            expect(subject.first_name).to eq('fn')
        end

        it 'reads and writes :last_name' do
            subject.last_name = 'ln'
            expect(subject.last_name).to eq('ln')
        end
    end

    describe 'associations' do
        before do
            create(:little_brother_chip, user: subject) do |lil_chip|
                create(:location, little_brother_chip: lil_chip)
            end
        end

        it 'has a little_brother_chip' do
            expect(subject.little_brother_chip).to be_a(LittleBrotherChip)
        end

        it 'has a location' do
            expect(subject.location).to be_a(Location)
        end
    end
end
