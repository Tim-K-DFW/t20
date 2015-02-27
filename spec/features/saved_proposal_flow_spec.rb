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


  scenario 'user goes back to page 1 of proposal'
  scenario 'user saves the updates'
  scenario 'user sees the updated attributes in proposal list'

end