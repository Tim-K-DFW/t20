class Proposal < ActiveRecord::Base

  INCOME_TAX_RATE = 0.4

  with_options if: lambda { |p| p.current_step == 1 } do |step_1|
    step_1.validates :date, length: {in: 3..25}, allow_blank: true
    step_1.validates :recruiting_firm, length: {in: 3..40}, allow_blank: true
    step_1.validates :phone, length: {in: 3..15}, allow_blank: true
    step_1.validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, length: {in: 7..40}, allow_blank: true
    step_1.validates :producer, length: {in: 3..25}, allow_blank: true
    step_1.validates :current_age, presence: true, numericality: { only_integer: true, greater_than: 20, less_than: 70 }
    step_1.validates :retirement_age, presence: true, numericality: { only_integer: true,  greater_than: 25, less_than: 70}
  end

  with_options if: lambda { |p| p.current_step == 2 } do |step_2|
    step_2.validates :current_production, presence: true, numericality: { only_integer: true, greater_than: 100000, less_than: 100000000 }
    step_2.validates :current_payout, presence: true, numericality: { greater_than: 1, less_than: 100 }
    step_2.validates :production_growth, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 100 }
    step_2.validates :new_payout, presence: true, numericality: { greater_than: 1, less_than: 100 }
    step_2.validates :bonus, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 500000000 }
    step_2.validates :new_firm, length: {in: 3..40}, allow_blank: true
  end

  attr_writer :current_step
  attr_accessor :table, :capitalized

  def current_step
    @current_step || steps.first
  end

  def steps
    (1..3).to_a         # 1 and 2 for input screen; 3 for proposal preview (user can go back to page 2 from it)
  end

  def next_step
    self.current_step = steps[steps.index(current_step) + 1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step) - 1] unless self.first_step?
  end

  def final_step?
    current_step == steps.size
  end

  def first_step?
    current_step == steps.first
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def timeframe
    result = [0]
    projection_length = retirement_age - current_age
    if projection_length <= 5
      (1..projection_length).each {|y| result << y}
    else
      (1..3).each {|y| result << y}
      (1..((projection_length - 1) / 5).truncate).each {|y| result << y * 5}
      result << projection_length
    end
    return result
  end #timeframe

  def generate
    output = Output.new(self)
    
    @table = {}
    timeframe.each do |year| 
      @table[year] = output.fill_year(year)
    end
    
    @table[0][:new_payout_val] = nil
    @table[0][:additional_payout] = nil
    @table[0][:additional_payout_after_tax] = nil
    @table[0][:bonus] = bonus
    
    @capitalized = output.capitalized
  end
end