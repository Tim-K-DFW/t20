class ProposalsController < ApplicationController
  def homepage
  end

  def new
    @proposal = Proposal.new
  end
end