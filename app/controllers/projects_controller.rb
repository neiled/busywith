class ProjectsController < ApplicationController
  before_filter :require_user
  
  def new
    @team = Team.find(params[:team_id])
    @project = @team.projects.new
  end

  def create
    @team = Team.find(params[:team_id])
    @project = @team.projects.build(params[:project])
    
    if @project.save    
      flash[:notice] = "Project Added...#{@project.name}"
    else
      flash[:error] = @project.errors.full_messages.to_s
    end
      
    respond_to do |wants|
      wants.html { redirect_to team_path(@team) }
      wants.js { }
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @team = @project.team
    @project.destroy
    
    respond_to do |format|
        format.html { redirect_to edit_team_url(@team) }
        format.js { render :nothing => true }
    end
    
  end

end
