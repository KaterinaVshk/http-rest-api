require 'rails_helper'
RSpec.describe Employee, type: :model do
    
    describe 'validations' do
        describe '#name' do
            it { is_expected.to(validate_presence_of(:name)) }
        end

        describe '#id' do
            it { is_expected.to(validate_uniqueness_of(:id)) }
        end
    end

    describe 'belongs_to' do
        it { should belong_to(:company) }
    end
end    