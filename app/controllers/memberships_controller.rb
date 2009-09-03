class MembershipsController < ApplicationController
  
  before_filter :require_user
  
  def create
    @team = current_user.owned_teams.find_by_id(params[:team_id])
    if @team.nil?
      flash[:error] = "You do not own that team."
      redirect_to :back
      return
    end
    
    @user = User.find_by_email(params[:email].downcase)
    if @user.nil?
      @user = User.new(:email => params[:email])
      @user.save_with_validation(false)
    end
    
    @membership = @user.memberships.build(:team_id => @team.id, :user_id => @user.id, :invitor_id => current_user.id)
    if @membership.save
      flash[:notice] = "Invited user."
    else
      flash[:error] = @membership.errors.full_messages
    end
    redirect_to @team

  end

  def update
    @membership = current_user.invites.find_by_id(params[:id])
    unless @membership.nil?
      @membership.update_attribute(:accepted_at, DateTime.now)
      flash[:notice] = "Invite Accepted"
    else
      flash[:error] = "That invite does not exist"
    end
    redirect_to :back        
  end
  
  def destroy
    #see if the membership id is a membership that the current user has
    @membership = current_user.memberships.find_by_id(params[:id])
    #if it's not, see if it's an invite they have
    @membership ||= current_user.invites.find_by_id(params[:id])
    # If we still didn't find a membership, then look to see if the membership_id relates a membership of a team that the current user owns
    # this way the current user can remove someone from their team
    if @membership.nil?
      #does the membership exist at all?
      found_membership = Membership.find(params[:id])
      unless found_membership.nil?
        #if it does, see if the current user owns a team with that the membership points to
        @membership ||= current_user.owned_teams.find_by_id(found_membership.team_id).nil? ? nil : found_membership
      end
    end
    unless @membership.nil?
      flash[:notice] = @membership.accepted_at.nil? ?
      "Invite Ignored." :
      current_user.owned_teams.find_by_id(@membership.team) ?
      "#{@membership.user.login.capitalize} has been removed from the team" :
      "You are no longer a member of the team #{@membership.team.name}"
      @membership.destroy      
    else
      flash[:error] = "That invite does not exist"
    end
    redirect_to :back
  end

end
