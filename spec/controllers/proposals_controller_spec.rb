require 'spec_helper'

describe ProposalsController do
  describe 'GET index' do
    it 'assigns all proposals to an insatance variable' do
      5.times { Fabricate(:proposal) }
      get :index
      expect(assigns(:proposals)).to eq(Proposal.all)
    end
  end

  describe 'GET new' do
    it 'creates a new proposal object' do
      get :new
      expect(assigns(:proposal)).to be_instance_of(Proposal)
    end

    it 'resets proposal params in session' do
      get :new
      expect(session[:proposal_params]).to be_blank
    end
  end

  describe 'GET show' do
    # it 'finds correct proposal inputs' do
    #   test = Fabricate(:proposal)
    #   get :show, id: test.id
    #   binding.pry
    #   expect(assigns(:this_proposal)).to eq(test.attributes)
    # end

    it 'generates params for CREATE action' do
      proposal = Fabricate(:proposal)
      get :show, id: proposal.id
    end

    it 'redirects to CREATE action' do
      proposal = Fabricate(:proposal)
      get :show, id: proposal.id
      expect(response).to redirect_to('create')
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

      it 'does not save proposal on generation alone' do
        entries_count = Proposal.all.count
        expect(entries_count).to eq(0)
      end
    end # with valid inputs
  end

  describe 'POST save' do
    context 'with valid inputs' do
      before { post :save, proposal: {current_age: 25, retirement_age: 55, current_production: 2000000, current_payout: 45, production_growth: 7, new_payout: 55, bonus: 2000000} }

      it 'creates a new record with proposal inputs' do
        entry = Proposal.last
        expect(entry.current_age).to eq(25)
        expect(entry.retirement_age).to eq(55)
        expect(entry.current_production).to eq(2000000)
        expect(entry.current_payout).to eq(45)
        expect(entry.production_growth).to eq(7)
        expect(entry.new_payout).to eq(55)
        expect(entry.bonus).to eq(2000000)
      end

      it 'dispays success message' do
        expect(flash.now[:success]).to eq('Proposal was successfully saved.')
      end

      it 'renders proposal page again' do
        expect(response).to render_template('result')
      end
    end

    context 'with invalid inputs' do
      before do
        begin
          post :save, proposal: {bonus: 2000000}
        rescue
        end
      end

      it 'does not create a new record' do
        expect(Proposal.all.count).to eq(0)
      end

      it 'displays error message' do
        expect(flash.now[:danger]).to eq('There was an error and proposal was not saved. Please try again.')
      end

    end  #  with invalid inputs
  end   # POST SAVE
end