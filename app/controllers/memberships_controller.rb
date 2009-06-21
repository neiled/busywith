class MembershipsController < ApplicationController
  def create
    @team = current_user.owned_teams.find_by_id(params[:team_id])
    if @team.nil?
      flash[:error] = "You do not own that team."
      redirect_to :back
      return
    end
    
    @user = User.find_by_login(params[:username])
    if @user.nil?
      flash[:error] = "Unknown user."
      redirect_to(@team)
    else
      @membership = @user.memberships.build(:team_id => @team, :user_id => @user)
      if @membership.save
        flash[:notice] = "Invited user."
      else
        flash[:error] = @membership.errors
      end
        redirect_to @team
    end
  end

  def accept
    @membership = current_user.memberships.find_by_id(params[:membership_id])
    unless @membership.nil?
      @membership.accepted_at = DateTime.now
      if @membership.save
        flash[:notice] = "Invite Accepted"
      else
        flash[:error] = @membership.errors
      end
    else
      flash[:error] = "That invite does not exist"
    end
    redirect_to :back        
  end
  
  def delete
    @membership = current_user.memberships.find_by_id(params[:membership_id])
    # If I didn't find a membership, then look to see if the membership_id is a membership of a team that the user owns
    # this way the user can remove someone from their team
    @membership ||= Membership.first(:joins => :team,
                  :conditions => {:id => params[:membership_id], :teams => {:owner_id => current_user}})
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
