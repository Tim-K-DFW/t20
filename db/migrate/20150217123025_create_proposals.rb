class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.date :date
      t.string :recruiting_firm, :phone, :email, :producer, :new_firm, :date
      t.integer :current_age, :retirement_age, :current_production, :bonus
      t.float :production_growth, :current_payout, :new_payout
      t.timestamps
    end
  end
end
