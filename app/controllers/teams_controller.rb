class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.xml
  def index
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    @new_project = @team.projects.new
  end

  # POST /teams
  # POST /teams.xml
  def create
    @team = Team.new(params[:team])
    if @team.save
      @membership = Membership.new(:user_id => current_user, :team_id => @team, :is_administrator => true, :accepted_at => DateTime.now)
      if @membership.save        
        flash[:notice] = 'Team was successfully created.'
        redirect_to(edit_team_path(@team))
        return
      end
    end
    render :action => "new"
  end

  # PUT /teams/1
  # PUT /teams/1.xml
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

  # DELETE /teams/1
  # DELETE /teams/1.xml
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
