class Output
  def initialize(args)
    @current_age = args[:current_age]
    @retirement_age = args[:retirement_age]
    @current_production = args[:current_production]
    @production_growth = args[:production_growth]
    @current_payout = args[:current_payout]
    @new_payout = args[:new_payout]
    @bonus = args[:bonus]
  end

  def fill_year(year)
    this_column = {}
    this_column[:age] = @current_age + year
    this_column[:gross_production] = (@current_production * ((1 + @production_growth / 100) ** year)).round
    this_column[:current_payout_val] = (this_column[:gross_production] * (@current_payout / 100)).round
    this_column[:new_payout_val] = (this_column[:gross_production] * (@new_payout / 100)).round
    this_column[:additional_payout] = this_column[:new_payout_val] - this_column[:current_payout_val]
    this_column[:additional_payout_after_tax] = this_column[:additional_payout] * (1 - Proposal::INCOME_TAX_RATE)
    this_column
  end

  def capitalized
    result = {}
    result[:bonus] = (@bonus * (1.05 ** (@retirement_age - @current_age))).round
    result[:payout] = capitalized_annuity
    result[:total] = result[:bonus] + result[:payout]
    result
  end

  def capitalized_annuity
    p = (@new_payout - @current_payout) / 100 * (@current_production * (1 + @production_growth / 100)) * (1 - Proposal::INCOME_TAX_RATE)
    r = 0.05
    g = @production_growth / 100
    n = @retirement_age - @current_age
    temp = (p*(((1+r)**n-(1+g)**n)/(r-g)))
    temp.nan? ? 0 : temp.round
  end

end