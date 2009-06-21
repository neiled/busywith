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
    @team = current_user.owned_teams.build

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
    @team = current_user.owned_teams.build(params[:team])
    respond_to do |format|
      if @team.save
        flash[:notice] = 'Team was successfully created.'
        format.html { redirect_to(edit_team_path(@team)) }
        format.xml  { render :xml => @team, :status => :created, :location => @team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
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
