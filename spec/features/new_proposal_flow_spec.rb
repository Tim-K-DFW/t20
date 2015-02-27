require 'spec_helper'

feature 'user creates new proposal straight through' do

  scenario 'user clicks New Proposal from homepage' do
    visit '/'
    click_link 'New Proposal'
    expect(page).to have_content('Proposal date')
  end

  scenario 'user fills 1st page of form' do
    visit '/'
    click_link 'New Proposal'
    fill_in 'Current age', with: 25
    fill_in 'Planned retirement age', with: 55
    click_button 'Next Step'
    expect(page).to have_content('Sign-in bonus')
  end
  
  scenario 'user fills 2nd page of form' do
    visit '/'
    click_link 'New Proposal'
    fill_in 'Current age', with: 25
    fill_in 'Planned retirement age', with: 55
    click_button 'Next Step'
    fill_in 'Annual gross production, $', with: 500000
    fill_in :proposal_current_payout, with: 45
    fill_in 'Annual production growth rate, %', with: 7
    fill_in :proposal_new_payout, with: 65
    fill_in 'Sign-in bonus', with: 500000
    click_button 'Next Step'
    expect(page).to have_content('net worth')
  end
end