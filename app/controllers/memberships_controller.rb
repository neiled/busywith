class MembershipsController < ApplicationController
  def create
    @team = current_user.teams.find_by_id(params[:team_id])
    if @team.nil?
      flash[:error] = "You do not own that team."
      redirect_to :back
    else
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
  end

  def new
  end

end
