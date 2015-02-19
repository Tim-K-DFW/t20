require 'spec_helper'

describe Proposal do
  
  # context 'at step 1' do
  #   proposal = Proposal.new
  #   proposal.current_step = 1
  #   it { is_expected.to validate_length_of(:date).is_at_least(3).is_at_most(25) }
  #   it { is_expected.to validate_length_of(:recruiting_firm).is_at_least(3).is_at_most(25) }
  #   it { is_expected.to validate_length_of(:phone).is_at_least(3).is_at_most(15) }
  #   it { is_expected.to validate_length_of(:email).is_at_least(7).is_at_most(40) }
  #   it { is_expected.to validate_length_of(:producer).is_at_least(3).is_at_most(25) }

  #   it { is_expected.to validate_presence_of(:current_age) }
  #   it { is_expected.to validate_numericality_of(:current_age).only_integer }
  #   it { is_expected.to validate_numericality_of(:current_age).is_greater_than(20) }
  #   it { is_expected.to validate_numericality_of(:current_age).is_less_than(70) }

  #   it { is_expected.to validate_presence_of(:retirement_age) }
  #   it { is_expected.to validate_numericality_of(:retirement_age).only_integer }
  #   it { is_expected.to validate_numericality_of(:retirement_age).is_greater_than(25) }
  #   it { is_expected.to validate_numericality_of(:current_age).is_less_than(70) }
  # end

  # context 'at step 2' do                          # after spending an hour trying to get this to work, moving on
  #   proposal = Proposal.new
  #   proposal.current_step = 2
  #   it { is_expected.to validate_presence_of(:current_production) }
  #   it { is_expected.to validate_numericality_of(:current_production).only_integer }
  #   it { is_expected.to validate_numericality_of(:current_production).is_greater_than(100000) }
  #   it { is_expected.to validate_numericality_of(:current_production).is_less_than(100000000) }
    
  #   it { is_expected.to validate_presence_of(:current_payout) }
  #   it { is_expected.to validate_numericality_of(:current_payout).is_greater_than_or_equal_to(1) }
  #   it { is_expected.to validate_numericality_of(:current_payout).is_less_than(100) }

  #   it { is_expected.to validate_presence_of(:production_growth) }
  #   it { is_expected.to validate_numericality_of(:production_growth).is_greater_than_or_equal_to(0) }
  #   it { is_expected.to validate_numericality_of(:production_growth).is_less_than(100) }

  #   it { is_expected.to validate_presence_of(:new_payout) }
  #   it { is_expected.to validate_numericality_of(:new_payout).is_greater_than_or_equal_to(1) }
  #   it { is_expected.to validate_numericality_of(:new_payout).is_less_than(100) }

  #   it { is_expected.to validate_presence_of(:bonus) }
  #   it { is_expected.to validate_numericality_of(:bonus).only_integer }
  #   it { is_expected.to validate_numericality_of(:bonus).is_greater_than_or_equal_to(0) }
  #   it { is_expected.to validate_numericality_of(:bonus).is_less_than(500000000) }

  #   it { is_expected.to validate_length_of(:new_firm).is_at_least(3).is_at_most(25) }
  # end

  describe '#timeframe' do
    let(:proposal) { Proposal.new(current_age: 20) }

    it 'returns an array of integers' do
      proposal.retirement_age = 30
      expect(proposal.timeframe).to be_kind_of(Array)
    end

    it 'includes year 0' do
      proposal.retirement_age = 30
      expect(proposal.timeframe).to include(0)
    end

    it 'includes every year for a range of 5 years' do
      proposal.retirement_age = 25
      expect(proposal.timeframe).to contain_exactly(0, 1, 2, 3, 4, 5)
    end

    it 'includes every year for a range of 4 years' do
      proposal.retirement_age = 24
      expect(proposal.timeframe).to contain_exactly(0, 1, 2, 3, 4)
    end

    it 'includes every year for a range of 3 years' do
      proposal.retirement_age = 23
      expect(proposal.timeframe).to contain_exactly(0, 1, 2, 3)
    end

    it 'includes years 1, 2, 3, 5, 10 for a range of 10 years' do
      proposal.retirement_age = 30
      expect(proposal.timeframe).to contain_exactly(0, 1, 2, 3, 5, 10)
    end

    it 'includes years 1, 2, 3, 5, 10, 15, 20, 25, 30, 32 for a range of 32 years' do
      proposal.retirement_age = 52
      expect(proposal.timeframe).to contain_exactly(0, 1, 2, 3, 5, 10, 15, 20, 25, 30, 32)
    end
  end # #.timeframe
    
end