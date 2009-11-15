class TeamsController < ApplicationController
  before_filter :require_user

  def show
    @team = current_user.all_teams.find(params[:id])
    @project = @team.projects.new
    previous_time_string = params[:last_updated] || 1.year.from_now.to_s
    @previous_time = Time.parse(previous_time_string)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
      format.js
    end
  end

  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  def edit
    @team = current_user.all_teams.find(params[:id])
    @new_project = @team.projects.new
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      @membership = Membership.new(:user_id => current_user.id, :team_id => @team.id, :is_administrator => true, :accepted_at => DateTime.now)
      if @membership.save        
        flash[:notice] = "Team was successfully created"
        redirect_to(edit_team_path(@team))
        return
      end
    end
    render :action => "new"
  end

  def update
    @team = current_user.owned_teams.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        flash[:notice] = 'Team updated.'
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def destroy
    @team = current_user.owned_teams.find(params[:id])
    @team.destroy

    respond_to do |format|
      flash[:notice] = "Team Deleted."
      format.html { redirect_to(profile_path(current_user.login)) }
      format.xml  { head :ok }
    end
  end
end
