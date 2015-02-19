require 'spec_helper'

describe Proposal do
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
  
  describe '#generate' do
    let(:proposal) { Proposal.new(current_age: 30, retirement_age: 53, current_production: 1000000, current_payout: 45, production_growth: 10, new_payout: 60, bonus: 2000000) }

    it 'creates a hash of hashes whose keys are years' do
      report = proposal.generate
      expect(report.keys).to eq([0, 1, 2, 3, 5, 10, 15, 20, 23])
    end

    it 'fills 0 year subhash with correct values' do
      report = proposal.generate
      expect(report[0][:age]).to eq(30)
      expect(report[0][:gross_production]).to eq(1000000)
      expect(report[0][:current_payout_val]).to eq(450000)
      expect(report[0][:bonus]).to eq(2000000)
    end

    it 'fills a non-0 year subhash with correct values' do
      report = proposal.generate

    end


    it 'creates the totals hash with correct values'
  end

  describe '#totals' do
    it 'creates a hash with correct values'
  end
end