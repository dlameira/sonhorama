class ProjectsController < ApplicationController
  before_action :set_project, only: [:show]

  def index
    @project = Project.all
  end

  def show
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :callout, :collaborators, :client, :date)
  end
end
