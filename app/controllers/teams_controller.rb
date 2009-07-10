class TeamsController < ApplicationController
  before_filter :require_user

  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
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
    @team = Team.find(params[:id])
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
    @team = Team.find(params[:id])

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
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      flash[:notice] = "Team Deleted."
      format.html { redirect_to(profile_path(current_user.login)) }
      format.xml  { head :ok }
    end
  end
end
