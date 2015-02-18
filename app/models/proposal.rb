class Proposal < ActiveRecord::Base
  validates_presence_of [:current_age, :retirement_age, :current_production, :current_payout, :new_payout, :bonus, :production_growth]
   validates_numericality_of [:current_age, :retirement_age, :current_production, :bonus], only_integer: true
   validates_numericality_of [:current_payout, :new_payout, :production_growth]
   validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
   validates_length_of [:recruiting_firm, :producer, :new_firm], in: 3..25
   validates_length_of :phone, maximum: 15
   validates_length_of :email, in: 7..35
end