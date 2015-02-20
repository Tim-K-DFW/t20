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
    let(:proposal) { Proposal.new(current_age: 30, retirement_age: 53, current_production: 2000000, current_payout: 45, production_growth: 7, new_payout: 55, bonus: 4000000) }
    let(:report) { proposal.generate }

    it 'creates a hash of hashes whose keys are years' do
      expect(report.keys).to eq([0, 1, 2, 3, 5, 10, 15, 20, 23, capitalized:])
    end

    it 'fills 0 year subhash with correct values' do
      expect(report[0][:age]).to eq(30)
      expect(report[0][:gross_production]).to eq(2000000)
      expect(report[0][:current_payout_val]).to eq(900000)
      expect(report[0][:bonus]).to eq(4000000)
      expect(report[0][:new_payout_val]).to eq(nil)
      expect(report[0][:additional_payout]).to eq(nil)
    end

    it 'fills a non-0 year subhash with correct values' do
      expect(report[1][:age]).to eq(31)
      expect(report[1][:gross_production]).to eq(2140000)
      expect(report[1][:current_payout_val]).to eq(963000)
      expect(report[1][:new_payout_val]).to eq(1177000)
      expect(report[1][:additional_payout]).to eq(214000)
      expect(report[1][:bonus]).to eq(nil)
    end


    it 'creates the totals hash with correct values' do
      expect(report[:capitalized][:bonus]).to eq(12286095)
      expect(report[:capitalized][:payout]).to eq(7277106)
      expect(report[:capitalized][:total]).to eq(15592819)
    end
  end

  describe '#totals' do
    it 'creates a hash with correct values'
  end
end