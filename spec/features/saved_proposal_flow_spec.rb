require 'spec_helper'

feature 'user selects, updates and saves an existing proposal' do

  given!(:proposal1) { Fabricate(:proposal) }
  given!(:proposal2) { Fabricate(:proposal) }

  scenario 'user goes to proposal list from home page' do
    visit '/'
    click_link 'Saved Proposals'
    expect(page).to have_content(proposal1.producer)
  end

  scenario 'user choses a previously saved proposal' do
    visit '/'
    click_link 'Saved Proposals'
    click_link "proposal_#{proposal1.id}_load"
    expect(page).to have_content('net worth')    
  end

  scenario 'user goes back to page 2 of proposal' do
    visit '/'
    click_link 'Saved Proposals'
    click_link "proposal_#{proposal1.id}_load"
    click_link 'Edit'
    expect(page).to have_content('Sign-in bonus')
  end

  scenario 'user goes back to page 1 of proposal' do
    visit '/'
    click_link 'Saved Proposals'
    click_link "proposal_#{proposal1.id}_load"
    click_link 'Edit'
    click_button 'Back'
    expect(page).to have_content('Proposal date')
  end

  scenario 'user updates a field and sees change in the proposal' do
    visit '/'
    click_link 'Saved Proposals'
    click_link "proposal_#{proposal1.id}_load"
    click_link 'Edit'
    click_button 'Back'
    fill_in 'Recruiter', with: 'Magnificent'
    click_button 'Next Step'
    click_button 'Next Step'
    expect(find('#recruiter')).to have_content('Magnificent')
  end

  scenario 'user updates a field, saves it and sees change in proposal index' do
    visit '/'
    click_link 'Saved Proposals'
    click_link "proposal_#{proposal1.id}_load"
    click_link 'Edit'
    fill_in 'Annual gross production, $', with: 444555
    click_button 'Next Step'
    click_link 'Save'
    expect(page).to have_content('successfully updated')
    click_link 'Main Menu'
    click_link 'Saved Proposals'
    expect(page).to have_content('444,555')
  end
end