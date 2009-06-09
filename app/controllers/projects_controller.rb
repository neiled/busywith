class ProjectsController < ApplicationController

  def new
    @team = Team.find(params[:team_id])
    @project = @team.projects.new
  end

  def create
    @team = Team.find(params[:team_id])
    @project = @team.projects.build(params[:project])
    if @project.save
      flash[:notice] = "Project Added..."
      redirect_to edit_team_path(@team)
    else
      flash[:error] = @project.errors
      render :action => "new"
    end      
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project Deleted."
    redirect_to :controller => "teams", :action => "edit"
  end

end
