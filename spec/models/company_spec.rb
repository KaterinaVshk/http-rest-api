require 'rails_helper'
RSpec.describe Company, type: :model do
    
    describe 'validations' do
        describe '#legalForm' do
        it { is_expected.to(validate_inclusion_of(:legalForm).in_array(%w[OOO ZAO IP])) }
        it { is_expected.to(allow_value(nil).for(:legalForm) )  }
    end

        describe '#id' do
            it { is_expected.to(validate_uniqueness_of(:id)) }
            it {  should validate_numericality_of(:id).
                       is_greater_than(0)}
        end
    end

    describe 'has_many' do
        it { should respond_to(:employee) }
    end
end    