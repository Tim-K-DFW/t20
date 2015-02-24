class ProposalsController < ApplicationController
  def homepage
  end

  def new
    session[:proposal_params] ||= {}
    @proposal = Proposal.new(session[:proposal_params])
    @proposal.current_step = session[:proposal_step]
  end

  def create
    session[:proposal_params].deep_merge!(params[:proposal]) if params[:proposal]
    @proposal = Proposal.new(session[:proposal_params])
    @proposal.current_step = session[:proposal_step]
    if @proposal.valid?
      if params[:back_button]
        @proposal.previous_step
      elsif @proposal.final_step?
        @proposal.save if @proposal.all_valid?
      else
        @proposal.next_step
      end
      session[:proposal_step] = @proposal.current_step
    end
    if @proposal.new_record?
      render 'new'
    else
      @proposal.generate
      session[:proposal_step] = session[:proposal_params] = nil
      render 'result'
    end
  end

  private

  def get_params
    session.require(:proposal).permit!
  end
end