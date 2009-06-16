class MembershipsController < ApplicationController
  def create
    @team = current_user.teams.find_by_id(params[:team_id])
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

end
