require 'spec_helper'

describe ProposalsController do
  describe 'GET new' do
    it 'creates a new proposal object' do
      get :new
      expect(assigns(:proposal)).to be_instance_of(Proposal)
    end
  end
end