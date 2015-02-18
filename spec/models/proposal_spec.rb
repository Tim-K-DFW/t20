require 'spec_helper'

describe Proposal do
  it { is_expected.to validate_presence_of(:current_age) }
  it { is_expected.to validate_presence_of(:retirement_age) }
  it { is_expected.to validate_presence_of(:current_production) }
  it { is_expected.to validate_presence_of(:current_payout) }
  it { is_expected.to validate_presence_of(:new_payout) }
  it { is_expected.to validate_presence_of(:bonus) }
  it { is_expected.to validate_presence_of(:production_growth) }

  it { is_expected.to validate_numericality_of(:current_age).only_integer }
  it { is_expected.to validate_numericality_of(:retirement_age).only_integer }
  it { is_expected.to validate_numericality_of(:current_production).only_integer }
  it { is_expected.to validate_numericality_of(:bonus).only_integer }
  it { is_expected.to validate_numericality_of(:current_payout) }
  it { is_expected.to validate_numericality_of(:new_payout) }
  it { is_expected.to validate_numericality_of(:production_growth) }

  it { is_expected.to validate_length_of(:recruiting_firm).is_at_least(3).is_at_most(25) }
  it { is_expected.to validate_length_of(:producer).is_at_least(3).is_at_most(25) }
  it { is_expected.to validate_length_of(:new_firm).is_at_least(3).is_at_most(25) }
  it { is_expected.to validate_length_of(:phone).is_at_most(15) }
  it { is_expected.to validate_length_of(:email).is_at_least(7).is_at_most(35) }
end