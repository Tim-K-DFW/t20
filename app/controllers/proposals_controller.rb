class ProposalsController < ApplicationController
  def homepage
  end

  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find(params[:id])
    @proposal.generate
    session[:proposal_params] = @proposal.attributes
    session[:proposal_step] = @proposal.steps.size
    render 'result'
  end

  def new
    session[:proposal_params] = {}
    session[:proposal_step] = nil
    @proposal = Proposal.new(session[:proposal_params])
    @proposal.current_step = session[:proposal_step]
  end

  def create
    session[:proposal_params].deep_merge!(params[:proposal]) if (params[:proposal] && session[:proposal_params])
    @proposal = Proposal.new(session[:proposal_params].except("created_at", "updated_at"))
    @proposal.current_step = session[:proposal_step]
    
    if @proposal.valid?                 # change current step depending on what button (Next or Back) called this action
      if params[:back_button]
        @proposal.previous_step
      elsif @proposal.final_step?
        @proposal.final = true if @proposal.all_valid?    # saving will trigger rendering result
      else
        @proposal.next_step
      end
      session[:proposal_step] = @proposal.current_step
    end
    
    if !@proposal.final_step?      # either render next step or generate result - depending on whether preview is final
      render 'new'
    else
      @proposal.generate
      # session[:proposal_step] = session[:proposal_params] = nil        # to allow user to go back to editing from preview screen
      render 'result'
    end
  end

  def save
    @proposal = Proposal.where(id: proposal_params[:id]).first
    if @proposal.blank?
      @proposal = Proposal.new(proposal_params)
      begin
        if @proposal.save
          flash.now[:success] = 'Proposal was successfully saved.'
        else
          flash.now[:danger] = 'There was an error and proposal was not saved. Please try again.'
        end
      rescue
        flash.now[:danger] = 'There was an error and proposal was not saved. Please try again.'  
      end
    else
      if Proposal.update(proposal_params[:id], proposal_params)
        Proposal.update(proposal_params[:id], proposal_params)
        Proposal.all.reload
        flash.now[:success] = 'Proposal was successfully updated.'
      else
        flash.now[:danger] = 'There was an error and proposal was not updated. Please try again.'
      end
    end
    @proposal.generate
    render 'result'
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    redirect_to proposals_path
  end

  private

  def proposal_params
    params.require(:proposal).permit!
  end
end