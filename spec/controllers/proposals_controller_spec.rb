require 'spec_helper'

describe ProposalsController do
  describe 'GET new' do
    it 'creates a new proposal object' do
      get :new
      expect(assigns(:proposal)).to be_instance_of(Proposal)
    end
  end

  describe 'POST create' do
    context 'with invalid inputs' do
      it 'does not switch to next page' do
        get :new
        post :create, proposal: {retirement_age: 55}
        expect(assigns(:proposal).current_step).to eq(1)
        expect(response).to render_template('new')
      end
    end

    context 'with valid inputs' do
      before do
        get :new
        post :create, proposal: {current_age: 25,retirement_age: 55}
        post :create, proposal: {current_production: 2000000, current_payout: 45, production_growth: 7, new_payout: 55, bonus: 2000000}
      end

      it 'fills output hash' do
        expect(assigns(:proposal).table).not_to be_empty
        expect(assigns(:proposal).capitalized).not_to be_empty
      end

      it 'renders proposal page' do
        expect(response).to render_template('result')
      end
    end
  end
end