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
      wants.html do
        redirect_to team_path(@team)
      end
      wants.js { }
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @team = @project.team
    @project.destroy
    flash[:notice] = "Project Deleted."
    redirect_to team_url(@team)
  end

end
